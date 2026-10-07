#include <windows.h>
#include <algorithm>
#include <chrono>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <vector>
#include "parser_layout.h"

extern "C" _memory_region_new *memory_region_create(u32);
extern "C" void parse_beatmap(_memory_region_header *, const char *, const char *);

#include "parser_output.h"

int main(int argc,char **argv) {
  if(argc<3) {std::cerr<<"usage: benchmark.exe MAPS LIMIT [OUTPUT.bin]\n";return 2;}
  auto limit=std::stoull(argv[2]);
  std::vector<std::filesystem::path> paths;
  for(const auto &p:std::filesystem::directory_iterator(argv[1]))
    if(p.path().extension()==".osu") paths.push_back(p.path());
  std::sort(paths.begin(),paths.end());
  if(limit && paths.size()>limit)paths.resize(limit);
  if(paths.empty())return 3;
  std::vector<std::vector<char>> maps;
  for(const auto &p:paths) {
    std::ifstream in(p,std::ios::binary);
    if(!in)return 4;
    std::vector<char> bytes((std::istreambuf_iterator<char>(in)),{});
    bytes.push_back('\n');bytes.resize(bytes.size()+128);maps.push_back(std::move(bytes));
  }
  SetThreadAffinityMask(GetCurrentThread(),1ull<<2);
  auto *memory=memory_region_create(0);if(!memory)return 5;
  auto parse=[&](const auto &m) {parse_beatmap(&memory->header,m.data(),m.data()+m.size()-129);};
  for(const auto &m:maps)parse(m);
  if(argc>3) {
    std::ofstream stream(argv[3],std::ios::binary);
    Output out(stream);if(!out.stream)return 6;
    for(const auto &m:maps){parse(m);out.map(memory->header);}
    if(!out.stream)return 7;
    std::cout<<"serialized "<<maps.size()<<" maps\n";return 0;
  }
  uint64_t checksum=0;
  for(int pass=0;pass<21;++pass) {
    auto start=std::chrono::steady_clock::now();
    for(int repeat=0;repeat<8;++repeat)for(const auto &m:maps) {
      parse(m);checksum+=memory->header.ELEM_COUNT[MEM_object_header];
    }
    auto elapsed=std::chrono::duration<double,std::nano>(std::chrono::steady_clock::now()-start).count();
    std::cout<<"pass="<<pass<<" ns_per_map="<<elapsed/(maps.size()*8)<<"\n";
  }
  std::cout<<"checksum="<<checksum<<" maps="<<maps.size()<<"\n";
}
