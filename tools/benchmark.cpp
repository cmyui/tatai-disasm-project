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

int main(int argc,char **argv) {
  if(argc<2) {std::cerr<<"usage: benchmark.exe MAPS [LIMIT=20001] [PASSES=5]\n";return 2;}
  const auto limit=argc>2?std::stoull(argv[2]):20001;
  const int passes=argc>3?std::stoi(argv[3]):5;
  std::vector<std::filesystem::path> paths;
  for(const auto &p:std::filesystem::directory_iterator(argv[1]))
    if(p.path().extension()==".osu")paths.push_back(p.path());
  std::sort(paths.begin(),paths.end());
  if(limit && paths.size()>limit)paths.resize(limit);
  if(paths.empty() || passes<1)return 3;
  std::vector<std::vector<char>> maps;
  for(const auto &p:paths) {
    const auto length=std::filesystem::file_size(p);
    std::vector<char> bytes(64+length+129);
    std::ifstream in(p,std::ios::binary);
    if(!in.read(bytes.data()+64,length))return 4;
    bytes[64+length]='\n';maps.push_back(std::move(bytes));
  }
  if(!SetThreadAffinityMask(GetCurrentThread(),1ull<<2))return 8;
  auto *memory=memory_region_create(0);if(!memory)return 5;
  auto parse=[&](const auto &m) {parse_beatmap(&memory->header,m.data()+64,m.data()+m.size()-129);};
  for(const auto &m:maps)parse(m);
  uint64_t checksum=0;
  for(int pass=0;pass<passes;++pass) {
    auto start=std::chrono::steady_clock::now();
    for(int repeat=0;repeat<4;++repeat)for(const auto &m:maps)parse(m);
    auto elapsed=std::chrono::duration<double,std::nano>(std::chrono::steady_clock::now()-start).count();
    checksum+=memory->header.ELEM_COUNT[MEM_object_header];
    std::cout<<"pass="<<pass<<" ns_per_map="<<elapsed/(maps.size()*4)<<'\n';
  }
  std::cout<<"checksum="<<checksum<<" maps="<<maps.size()<<'\n';
}
