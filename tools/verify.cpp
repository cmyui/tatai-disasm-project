#include <windows.h>
#include <algorithm>
#include <chrono>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <sstream>
#include <vector>
#include "parser_output.h"

extern "C" _memory_region_new *memory_region_create(u32);
extern "C" void parse_beatmap(_memory_region_header *, const char *, const char *);
extern "C" void reference_parse_beatmap(_memory_region_header *, const char *, const char *);

struct Verify {
  _memory_region_new *memory = memory_region_create(0);
  _memory_region_new *reference_memory = memory_region_create(0);
  size_t checked = 0;
  bool map(const char *start, const char *end) {
    std::ostringstream reference, candidate;
    Output ref(reference), out(candidate);
    reference_parse_beatmap(&reference_memory->header, start, end);ref.map(reference_memory->header);
    parse_beatmap(&memory->header, start, end);out.map(memory->header);
    ++checked;
    auto ref_bytes=reference.str(),candidate_bytes=candidate.str();
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
  if(argc<2){std::cerr<<"usage: verify.exe MAPS [LIMIT] [--benchmark]\n";return 2;}
  Verify verify;if(!verify.memory || !verify.reference_memory)return 3;
  bool benchmark=argc>3 && std::string(argv[3])=="--benchmark";
  std::vector<std::vector<char>> maps;
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
  const auto guarded_cases=verify.checked;
  std::vector<std::filesystem::path> paths;
  for(const auto &p:std::filesystem::directory_iterator(argv[1]))if(p.path().extension()==".osu")paths.push_back(p.path());
  std::sort(paths.begin(),paths.end());
  if(argc>2){auto limit=std::stoull(argv[2]);if(limit && paths.size()>limit)paths.resize(limit);}
  if(paths.empty())return 5;
  for(size_t i=0;i<paths.size();++i) {
    std::ifstream in(paths[i],std::ios::binary);if(!in)return 6;
    std::vector<char> bytes((std::istreambuf_iterator<char>(in)),{});
    unsigned offset=i&31;
    bytes.insert(bytes.begin(),32+offset,'\n');
    size_t length=bytes.size()-32-offset;
    bytes.push_back('\n');bytes.resize(bytes.size()+128);
    if(!verify.map(bytes.data()+32+offset,bytes.data()+32+offset+length)) {
      std::cerr<<"mismatch: "<<paths[i]<<"\n";return 7;
    }
    if(benchmark)maps.push_back(std::move(bytes));
    if((i+1)%4096==0)std::cout<<"verified_maps="<<i+1<<std::endl;
  }
  std::cout<<"matched="<<verify.checked<<" corpus_maps="<<paths.size()<<" guarded_cases="<<guarded_cases<<std::endl;
  if(benchmark) {
    SetThreadAffinityMask(GetCurrentThread(),1ull<<2);
    uint64_t checksum=0;
    for(int pass=0;pass<31;++pass) {
      double times[2]{};
      for(int round=0;round<2;++round) {
        int which=(pass+round)&1;
        auto fn=which ? parse_beatmap : reference_parse_beatmap;
        auto *memory=which ? verify.memory : verify.reference_memory;
        auto start=std::chrono::steady_clock::now();
        for(int repeat=0;repeat<4;++repeat)for(size_t i=0;i<maps.size();++i) {
          const auto &m=maps[i];
          fn(&memory->header,m.data()+32+(i&31),m.data()+m.size()-129);
          checksum+=memory->header.ELEM_COUNT[MEM_object_header];
        }
        times[which]=std::chrono::duration<double,std::nano>(std::chrono::steady_clock::now()-start).count()/(maps.size()*4);
      }
      std::cout<<"pass="<<pass<<" reference="<<times[0]<<" candidate="<<times[1]<<" ratio="<<times[1]/times[0]<<std::endl;
    }
    std::cout<<"checksum="<<checksum<<std::endl;
  }
}
