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
  std::cout<<"matched="<<verify.checked<<" corpus_maps="<<paths.size()<<" guarded_cases="<<objects.size()*64<<std::endl;
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
