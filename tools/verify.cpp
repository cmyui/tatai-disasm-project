#include <windows.h>
#include <algorithm>
#include <chrono>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <sstream>
#include <vector>
#include <cstdlib>
#include "parser_output.h"

extern "C" _memory_region_new *memory_region_create(u32);
extern "C" void parse_beatmap(void *, const char *, const char *);
extern "C" void reference_parse_beatmap(void *, const char *, const char *);
extern "C" void *reference_create();
extern "C" u32 reference_count(void *);
extern "C" void reference_reset(void *);
std::string reference_serialize(void *);
extern "C" uint64_t audit_parser_call(void *,const char *,const char *,void (*)(void *,const char *,const char *));

static size_t active_case;
static const char *active_parser="startup";
static LONG WINAPI report_fault(EXCEPTION_POINTERS *p) {
  std::cerr << "parser_fault case=" << active_case << " parser=" << active_parser
    << " code=" << std::hex << p->ExceptionRecord->ExceptionCode
    << " rva=" << (p->ContextRecord->Rip-reinterpret_cast<uintptr_t>(GetModuleHandle(nullptr)))
    << std::dec << std::endl;
  ExitProcess(9);
}

struct Verify {
  _memory_region_new *memory = memory_region_create(0);
  void *reference_memory = reference_create();
  size_t checked = 0;
  bool cold_corpus=false;
  void reset_candidate() {
    auto *h=&memory->header;
    for(size_t i=1;i<MEM_REGION_COUNT;++i) {
      if(h->ALLOC_COUNTS[i] && !VirtualFree(reinterpret_cast<char *>(h)+i*MEMORY_REGION_SIZE,h->ALLOC_COUNTS[i],MEM_DECOMMIT))
        throw std::runtime_error("candidate decommit failed");
      h->ALLOC_COUNTS[i]=0;
    }
  }
  void reset() {reset_candidate();reference_reset(reference_memory);}

  bool map(const char *start, const char *end) {
    if(cold_corpus)reset();
    std::ostringstream candidate;
    Output out(candidate);
    active_case=checked;active_parser="reference";
    auto ref_abi=audit_parser_call(reference_memory,start,end,reference_parse_beatmap);
    active_parser="candidate";
    auto abi=audit_parser_call(&memory->header,start,end,parse_beatmap);
    if(abi || ref_abi){std::cerr<<"ABI mismatch candidate="<<abi<<" reference="<<ref_abi<<"\n";return false;}
    out.map(memory->header);
    ++checked;
    auto ref_bytes=reference_serialize(reference_memory),candidate_bytes=candidate.str();
    if(ref_bytes!=candidate_bytes) {
      size_t first=0;
      while(first<ref_bytes.size() && first<candidate_bytes.size() && ref_bytes[first]==candidate_bytes[first])++first;
      std::cerr<<"first_difference="<<first<<" reference_bytes="<<ref_bytes.size()<<" candidate_bytes="<<candidate_bytes.size()<<"\n";
      std::ofstream("reference-mismatch.bin",std::ios::binary).write(ref_bytes.data(),ref_bytes.size());
      std::ofstream("candidate-mismatch.bin",std::ios::binary).write(candidate_bytes.data(),candidate_bytes.size());
      return false;
    }
    return true;
  }
};

// Readable input plus tail padding, between two inaccessible pages.
bool guarded(Verify &verify, const std::string &map, unsigned offset, bool tail) {
  constexpr size_t page = 4096;
  size_t readable = (map.size() + 128 + 64 + page - 1) & ~(page - 1);
  auto *allocation = static_cast<char *>(VirtualAlloc(nullptr, readable + 2*page, MEM_RESERVE, PAGE_NOACCESS));
  if(!allocation)return false;
  auto *buffer = static_cast<char *>(VirtualAlloc(allocation + page, readable, MEM_COMMIT, PAGE_READWRITE));
  if(!buffer){VirtualFree(allocation,0,MEM_RELEASE);return false;}
  char *start = buffer + offset;
  if(tail) {
    start = buffer + readable - 128 - map.size() - 31;
    start += (offset - (reinterpret_cast<uintptr_t>(start) & 31)) & 31;
  }
  memset(buffer,'\n',start-buffer);
  memcpy(start,map.data(),map.size());
  memset(start+map.size(),0,buffer+readable-start-map.size());
  bool match=verify.map(start,start+map.size());
  VirtualFree(allocation,0,MEM_RELEASE);
  return match;
}

int main(int argc,char **argv) {
  if(argc<2){std::cerr<<"usage: verify.exe MAPS [LIMIT] [--benchmark] [natural|varied]\n";return 2;}
  SetErrorMode(SEM_FAILCRITICALERRORS | SEM_NOGPFAULTERRORBOX);
  AddVectoredExceptionHandler(1,report_fault);
  Verify verify;if(!verify.memory || !verify.reference_memory)return 3;
  bool benchmark=argc>3 && std::string(argv[3])=="--benchmark";
  bool natural=argc>4 && std::string(argv[4])=="natural";
  std::vector<std::vector<char>> maps;
  uint64_t alignment_counts[32]{};
  const std::string header="osu file format v14\n\n[General]\nAudioFilename: test.mp3\nMode: 0\n\n[Difficulty]\nCircleSize:5\nOverallDifficulty:5\nApproachRate:9\nSliderMultiplier:1.4\nSliderTickRate:1\n\n[TimingPoints]\n0,500,4,2,1,100,1,0\n\n[HitObjects]\n";
  // Force the six-digit object-header fallback, negative/single-point sliders,
  // multi-point paths, large-coordinate fallback and multi-digit repeats/types.
  const std::vector<std::string> objects={
    "1234,1,600000,1,0,0:0:0:0:\n",
    "1234,1,50000,1,0,0:0:0:0:\n",
    // A fallback must preserve the table bases used by following fast objects.
    "1234,1,50000,1,0,0:0:0:0:\n256,192,50001,2,0,B|300:200|400:300,1,100\n-50,192,50002,134,0,B|-30:200,2,100.25\n",
    "1234,1,600000,1,0,0:0:0:0:\n256,192,600001,2,0,B|300:200|400:300,1,100\n-50,192,600002,134,0,B|-30:200,2,100.25\n",
    "1,1234,50000,2,0,B|300:200,1,100\n",
    "-50,192,50000,134,0,B|-30:200|400:-300,123,100.25\n",
    "256,192,1000,1,0,0:0:0:0:\n256,192,50000,2,0,B|300:200,1,100\n256,192,600000,2,0,B|300:200|400:300,1,100\n256,192,1000000,8,0,1100000,0:0:0:0:\n",
    "1,1234,600000,2,0,B|300:200,1,100\n",
    "256,192,600000,2,0,B|300:200|400:300,1,100\n",
    "256,192,600000,2,0,B|-30:200|400:-300,2,100.25\n",
    "256,192,600000,2,0,B|300:200|-400:300,12,100.25\n",
    "256,192,600000,2,0,B|3000:2000,1,100\n",
    "256,192,600000,134,0,B|300:200,1,100\n",
    "256,192,600000,8,0,700000,0:0:0:0:\n"
  };
  for(const auto &o:objects)for(unsigned offset=0;offset<32;++offset)for(bool tail:{false,true})
    if(!guarded(verify,header+o,offset,tail)){std::cerr<<"guarded mismatch: "<<o<<" offset="<<offset<<" tail="<<tail<<"\n";return 4;}
  // Exhaust positive-table shapes plus four-digit fallback shapes. Test both
  // a terminating comma and another point, at every guarded input alignment.
  for(unsigned coordinates : {2u,4u}) {
    for(unsigned shape=0;shape<(1u<<(2*coordinates));++shape) {
      std::string path;
      for(unsigned coordinate=0;coordinate<coordinates;++coordinate) {
        if(coordinate)path+=(coordinate&1)?':':'|';
        path+=std::string(1+((shape>>(2*coordinate))&3),'1');
      }
      for(bool more : {false,true}) {
        auto input=header+"256,192,600000,2,0,B|"+path+
                   (more?"|22:333,1,100\n":",1,100\n");
        for(unsigned offset=0;offset<32;++offset)for(bool tail:{false,true})
          if(!guarded(verify,input,offset,tail)) {
            std::cerr<<"slider shape mismatch: "<<path<<" more="<<more
                     <<" offset="<<offset<<" tail="<<tail<<"\n";return 4;
          }
      }
    }
  }
  // Paired headers: every 1-4 digit coordinate width, both hot timestamp
  // widths, and all circle/slider combinations. Four-digit coordinates defer.
  for(unsigned time : {50000u,500000u})for(unsigned shape=0;shape<256;++shape) {
    std::string xy[2];
    for(unsigned p=0;p<2;++p) {
      xy[p]=std::string(1+((shape>>(4*p))&3),'1')+","+
            std::string(1+((shape>>(4*p+2))&3),'2');
    }
    for(unsigned types=0;types<4;++types) {
      std::string input=header;
      for(unsigned p=0;p<2;++p)
        input+=xy[p]+","+std::to_string(time+p)+","+
               ((types&(1u<<p))?"2":"1")+",0,B|300:200,1,100\n";
      for(unsigned offset=0;offset<32;++offset)for(bool tail:{false,true})
        if(!guarded(verify,input,offset,tail)) {
          std::cerr<<"paired header mismatch: time="<<time<<" shape="<<shape
                   <<" types="<<types<<" offset="<<offset<<" tail="<<tail<<"\n";return 4;
        }
    }
  }
  // Long types and signed coordinates in each position of an odd run.
  for(unsigned time : {50000u,500000u})for(unsigned type : {12u,21u,128u,134u})
    for(unsigned position=0;position<3;++position) {
      std::string input=header;
      for(unsigned p=0;p<3;++p)
        input+=(p==position?"-50,192,":"256,192,")+std::to_string(time+p)+","+
               std::to_string(p==position?type:2u)+",0,B|300:200,1,100\n";
      for(unsigned offset=0;offset<32;++offset)for(bool tail:{false,true})
        if(!guarded(verify,input,offset,tail))return 4;
    }
  // Type bits must remain exact in either lane, including combo flags and
  // multi-digit types that must return to the original single-header path.
  for(unsigned time : {50000u,500000u})for(unsigned type=0;type<256;++type) {
    auto input=header;
    unsigned object_time=time;
    for(unsigned t : {type,2u,1u,type,2u})
      input+="256,192,"+std::to_string(object_time++)+","+std::to_string(t)+
             ",0,B|300:200,1,100\n";
    for(unsigned offset=0;offset<32;++offset)for(bool tail:{false,true})
      if(!guarded(verify,input,offset,tail)) {
        std::cerr<<"paired type mismatch: "<<type<<"\n";return 4;
      }
  }
  // Cross timestamp widths at both even and odd pairing positions, in both
  // directions, then require another successful pair after the transition.
  for(unsigned boundary : {10000u,100000u,1000000u})
    for(bool reverse : {false,true})for(unsigned prefix : {1u,2u}) {
      auto input=header;
      const unsigned first=reverse?boundary:boundary-1;
      const unsigned next=reverse?boundary-1:boundary;
      for(unsigned p=0;p<prefix+3;++p)
        input+="256,192,"+std::to_string(p<prefix?first:next)+
               ",2,0,B|300:200,1,100\n";
      for(unsigned offset=0;offset<32;++offset)for(bool tail:{false,true})
        if(!guarded(verify,input,offset,tail)) {
          std::cerr<<"paired width mismatch: "<<boundary<<" reverse="<<reverse
                   <<" prefix="<<prefix<<"\n";return 4;
        }
    }
  // Decimal pairs keep the reference's exact integer-to-double rounding.
  // Cover every digit/dot position visible to the 16-byte decoder, including
  // leading zeroes, maximum four-digit intermediates, and long input.
  std::vector<std::string> lengths={"0","1","9007199254740991","9007199254740992",
    "9007199254740993","9999999999999999","10000000000000000",
    "0.000000000000001","99999999.99999999"};
  for(unsigned digits=1;digits<=17;++digits)for(unsigned pattern=0;pattern<3;++pattern) {
    std::string value(digits,pattern==0?'0':'9');
    if(pattern==2)for(unsigned i=0;i<digits;++i)value[i]='0'+((i*7+3)%10);
    lengths.push_back(value);
    for(unsigned dot=0;dot<=digits;++dot) {
      auto decimal=value;decimal.insert(dot,1,'.');lengths.push_back(decimal);
    }
  }
  for(size_t i=0;i<lengths.size();++i) {
    auto input=header;
    for(const auto &length : {lengths[i],lengths[lengths.size()-1-i],
                              lengths[i],std::string("100.25"),lengths[i]})
      input+="256,192,600000,2,0,B|300:200,1,"+length+"\n";
    for(unsigned offset=0;offset<32;++offset)for(bool tail:{false,true})
      if(!guarded(verify,input,offset,tail)) {
        std::cerr<<"decimal pair mismatch: "<<lengths[i]<<" offset="<<offset
                 <<" tail="<<tail<<"\n";return 4;
      }
  }
  // Timing state: repeated values, inherited points before/after a base point,
  // negative timestamps, signed/fractional beat lengths, and version semantics.
  for(unsigned version : {7u,13u,14u,15u})for(unsigned seed=0;seed<32;++seed) {
    auto input=header;input.replace(input.find("v14"),3,"v"+std::to_string(version));
    const auto begin=input.find("0,500,");const auto end=input.find("[HitObjects]");
    std::string timings;
    for(unsigned i=0;i<24;++i) {
      const char *values[]={"500","-100","-50.125","333.333333333333","0.0000000001","100","-100"};
      timings+=std::to_string(int(i)*100-200)+","+values[(i+seed)%7]+",4,2,1,100,1,0\n";
      if((i+seed)%3==0)timings+=std::to_string(int(i)*100-200)+","+values[(i+seed)%7]+",4,2,1,100,1,0\n";
    }
    input.replace(begin,end-begin,timings+"\n");input+=objects[6];
    for(unsigned offset=0;offset<32;++offset)for(bool tail:{false,true})
      if(!guarded(verify,input,offset,tail)) {
        std::cerr<<"timing mismatch version="<<version<<" seed="<<seed<<"\n";return 4;
      }
  }
  // Dense masks, empty masks, long gaps, and transitions at SIMD boundaries.
  for(unsigned gap: {0u,1u,31u,32u,63u,64u,65u,127u,128u,511u,512u,4096u}) {
    auto input=header;
    input.insert(input.find("[General]"), "//"+std::string(gap,'x')+"\n"+std::string(gap%66,'\n'));
    input+=objects[6];
    for(unsigned offset=0;offset<32;++offset)for(bool tail:{false,true})
      if(!guarded(verify,input,offset,tail)){std::cerr<<"scanner guard mismatch gap="<<gap<<"\n";return 4;}
  }
  std::vector<std::string> chunk_maps;
  std::string short_times=header;
  for(unsigned i=0;i<1500;++i)short_times+="256,192,999,1,0,0:0:0:0:\n";
  chunk_maps.push_back(short_times);
  std::string transitions=header;
  for(const char *time:{"999","1000","9999","10000","99999","100000","999999","1000000"})
    for(unsigned i=0;i<257;++i)transitions+="256,192,"+std::string(time)+",2,0,B|-30:200|400:300,12,100.25\n";
  chunk_maps.push_back(transitions);
  auto gaps=header;
  gaps+="256,192,50000,1,0,"+std::string(70000,'0')+"\n256,192,50001,1,0,0:0:0:0:\n";
  chunk_maps.push_back(gaps);
  auto big_header=header;
  big_header.insert(big_header.find("[General]"),"//"+std::string(70000,'x')+"\n");
  chunk_maps.push_back(big_header+objects[6]);
  auto backwards=header;
  for(unsigned i=0;i<1000;++i)backwards+="256,192,50000,1,0,0:0:0:0:\n";
  backwards+="256,192,999,1,0,0:0:0:0:\n";
  chunk_maps.push_back(backwards);
  auto early_section=header;
  early_section.insert(early_section.find("[General]"),"[HitObjects]\n//"+std::string(70000,'x')+"\n");
  chunk_maps.push_back(early_section+objects[6]);
  for(const auto &input:chunk_maps)for(unsigned offset=0;offset<32;++offset)for(bool tail:{false,true})
    if(!guarded(verify,input,offset,tail)){std::cerr<<"chunk boundary mismatch offset="<<offset<<" tail="<<tail<<"\n";return 4;}
  // Deterministic field mutations, including recoverable slider delimiters.
  uint32_t random=0x91e10da5;
  auto next=[&](){random^=random<<13;random^=random>>17;return random^=random<<5;};
  for(unsigned seed=0;seed<128;++seed) {
    auto input=header;
    for(unsigned i=0;i<3;++i) {
      auto x=int(next()%3000)-500,y=int(next()%3000)-500;
      input+=std::to_string(x)+","+std::to_string(y)+","+std::to_string(next()%2000000)+
        ",2,0,B|"+std::to_string(x)+":"+std::to_string(y)+"|1:2,"+
        std::to_string(1+next()%150)+","+std::to_string(next()%100000)+"."+std::to_string(next())+"\n";
    }
    if(seed%4==0)input[input.find("|1:2")+2]=';';
    for(unsigned offset=0;offset<32;++offset)for(bool tail:{false,true})
      if(!guarded(verify,input,offset,tail)){std::cerr<<"mutation mismatch seed="<<seed<<"\n";return 4;}
  }
  // Padded truncated final object lines, with the header still complete.
  auto last=std::string("256,192,50000,2,0,B|123:45|6:789,12,123.456\n");
  for(size_t length=0;length<=last.size();++length)
    for(unsigned offset=0;offset<32;++offset)for(bool tail:{false,true})
      if(!guarded(verify,header+last.substr(0,length),offset,tail)) {
        std::cerr<<"truncated-tail mismatch length="<<length<<"\n";return 4;
      }
  // Cross the line-scratch commit boundary with a complete supported header.
  for(unsigned blanks:{65500u,65536u,65600u}) {
    auto at=header.find("[HitObjects]");
    auto input=header.substr(0,at)+std::string(blanks,'\n')+header.substr(at)+"256,192,50000,1,0\n";
    for(unsigned offset=0;offset<32;++offset)for(bool tail:{false,true})
      if(!guarded(verify,input,offset,tail)){std::cerr<<"scratch growth mismatch\n";return 4;}
  }
  const auto guarded_cases=verify.checked;
  if(const char *storage=std::getenv("TATAI_STORAGE")) {
    if(std::string(storage)!="warm")verify.reset();
    verify.cold_corpus=std::string(storage)=="first";
  }
  std::vector<std::filesystem::path> paths;
  for(const auto &p:std::filesystem::directory_iterator(argv[1]))if(p.path().extension()==".osu")paths.push_back(p.path());
  if(const char *list=std::getenv("TATAI_MAP_LIST")) {
    std::ifstream in(list);if(!in)return 5;
    std::vector<std::filesystem::path> selected;std::string name;
    while(std::getline(in,name)) {
      if(!name.empty() && name.back()=='\r')name.pop_back();
      selected.push_back(std::filesystem::path(argv[1])/std::filesystem::path(std::u8string(name.begin(),name.end())));
    }
    paths=std::move(selected);
  }
  std::sort(paths.begin(),paths.end());
  if(argc>2){auto limit=std::stoull(argv[2]);if(limit && paths.size()>limit)paths.resize(limit);}
  if(paths.empty())return 5;
  for(size_t i=0;i<paths.size();++i) {
    std::ifstream in(paths[i],std::ios::binary);if(!in)return 6;
    std::vector<char> bytes((std::istreambuf_iterator<char>(in)),{});
    unsigned offset=natural ? 0 : 32+(i&31);
    bytes.insert(bytes.begin(),offset,'\n');
    size_t length=bytes.size()-offset;
    bytes.push_back('\n');bytes.resize(bytes.size()+128);
    if(!verify.map(bytes.data()+offset,bytes.data()+offset+length)) {
      std::cerr<<"mismatch: "<<paths[i]<<"\n";return 7;
    }
    ++alignment_counts[reinterpret_cast<uintptr_t>(bytes.data()+offset)&31];
    if(benchmark)maps.push_back(std::move(bytes));
    if((i+1)%4096==0)std::cout<<"verified_maps="<<i+1<<std::endl;
  }
  std::cout<<"matched="<<verify.checked<<" corpus_maps="<<paths.size()<<" guarded_cases="<<guarded_cases<<std::endl;
  if(benchmark) {
    if(!SetThreadAffinityMask(GetCurrentThread(),1ull<<2))return 8;
    std::cout<<"benchmark_core=2 input_alignment_counts=";
    for(unsigned i=0;i<32;++i)std::cout<<(i?",":"")<<alignment_counts[i];
    std::cout<<std::endl;
    uint64_t checksum=0;
    const char *passes_env=std::getenv("TATAI_PASSES");
    int passes=passes_env?std::max(3,std::atoi(passes_env)):31;
    for(int pass=0;pass<passes;++pass) {
      double times[2]{};
      for(int round=0;round<2;++round) {
        int which=(pass+round)&1;
        auto fn=which ? parse_beatmap : reference_parse_beatmap;
        void *memory=which ? static_cast<void *>(&verify.memory->header) : verify.reference_memory;
        const char *storage=std::getenv("TATAI_STORAGE");
        bool cold=storage && std::string(storage)!="warm";
        auto reset=[&]() {
          if(!which){reference_reset(memory);return;}
          auto *h=&verify.memory->header;
          for(size_t i=1;i<MEM_REGION_COUNT;++i) {
            if(h->ALLOC_COUNTS[i])VirtualFree(static_cast<char *>(memory)+i*MEMORY_REGION_SIZE,h->ALLOC_COUNTS[i],MEM_DECOMMIT);
            h->ALLOC_COUNTS[i]=0;
          }
        };
        if(cold) {
          double elapsed=0;
          for(int repeat=0;repeat<4;++repeat) {
            if(std::string(storage)=="growth")reset();
            for(size_t i=0;i<maps.size();++i) {
              if(std::string(storage)=="first")reset();
              const auto &m=maps[i];
              auto start=std::chrono::steady_clock::now();
              fn(memory,m.data()+(natural ? 0 : 32+(i&31)),m.data()+m.size()-129);
              elapsed+=std::chrono::duration<double,std::nano>(std::chrono::steady_clock::now()-start).count();
            }
          }
          times[which]=elapsed/(maps.size()*4);
          checksum+=which ? verify.memory->header.ELEM_COUNT[MEM_object_header] : reference_count(memory);
          continue;
        }
        auto start=std::chrono::steady_clock::now();
        for(int repeat=0;repeat<4;++repeat)for(size_t i=0;i<maps.size();++i) {
          const auto &m=maps[i];
          fn(memory,m.data()+(natural ? 0 : 32+(i&31)),m.data()+m.size()-129);
        }
        times[which]=std::chrono::duration<double,std::nano>(std::chrono::steady_clock::now()-start).count()/(maps.size()*4);
        checksum+=which ? verify.memory->header.ELEM_COUNT[MEM_object_header] : reference_count(memory);
      }
      std::cout<<"pass="<<pass<<" reference="<<times[0]<<" candidate="<<times[1]<<" ratio="<<times[1]/times[0]<<std::endl;
    }
    std::cout<<"checksum="<<checksum<<std::endl;
  }
}
