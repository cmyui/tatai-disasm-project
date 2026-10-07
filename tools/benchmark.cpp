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

// Serialize semantic fields explicitly: pointers and structure padding are excluded.
struct Output {
  std::ofstream stream;
  explicit Output(const char *path) : stream(path, std::ios::binary) {}
  template<class T> void field(const T &v) { stream.write(reinterpret_cast<const char *>(&v), sizeof v); }
  void map(const _memory_region_header &h) {
    field(h.version_number);
    for (double v : h.osu_headers.table) field(v);
    field(h.osu_headers.Mode);
    u32 objects = h.ELEM_COUNT[MEM_object_header]; field(objects);
    for (u32 i=0;i<objects;++i) {
      const auto &o=h.get_object_header()[i];
      field(o.x);field(o.y);field(o.time);field(o.type);
      const auto &b=h.get_object_body()[i];
      if(o.type & 2) {
        field(b.length);field(b.slides);field(b.curve_type);
        u64 count=b.point_start ? b.point_end-b.point_start : 0; field(count);
        for(u64 j=0;j<count;++j) {field(b.point_start[j].x);field(b.point_start[j].y);}
      } else if(o.type & 8) {
        u32 end_time; std::memcpy(&end_time, &b, sizeof end_time); field(end_time);
      }
    }
    u32 timing=h.ELEM_COUNT[MEM_timing_point];field(timing);
    for(u32 i=0;i<timing;++i) {
      const auto &t=h.get_timing_point()[i];field(t.time);field(t.beat_length);field(t.tick_beat_length);
    }
  }
};

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
    Output out(argv[3]);if(!out.stream)return 6;
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
