#include <windows.h>
#include <bcrypt.h>
#include <algorithm>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <sstream>
#include <vector>
#include "parser_layout.h"
extern "C" { u64 sweep_counts[4]{}; }
extern "C" _memory_region_new *memory_region_create(u32);
extern "C" void parse_beatmap(_memory_region_header *,const char *,const char *);

int main(int argc,char **argv) {
  if(argc!=2)return 2;
  BCRYPT_ALG_HANDLE sha;
  if(BCryptOpenAlgorithmProvider(&sha,BCRYPT_SHA256_ALGORITHM,nullptr,0)<0)return 3;
  auto *region=memory_region_create(0);if(!region)return 4;
  std::vector<std::filesystem::path> paths;
  for(const auto &p:std::filesystem::directory_iterator(argv[1]))
    if(p.path().extension()==".osu")paths.push_back(p.path());
  std::sort(paths.begin(),paths.end());
  std::cout<<"file,sha256,bytes,version,objects,short_time,time4,time5,time6,time7,long_time,sliders,points,max_points,decimal_lengths,integer_lengths,long_lengths,object_fallback,slider_fallback,negative_calls\n";
  for(const auto &path:paths) {
    std::ifstream in(path,std::ios::binary);if(!in)return 5;
    std::vector<char> data((std::istreambuf_iterator<char>(in)),{});
    auto length=data.size();unsigned char digest[32];
    if(BCryptHash(sha,nullptr,0,reinterpret_cast<PUCHAR>(data.data()),ULONG(length),digest,32)<0)return 6;
    data.push_back('\n');data.resize(data.size()+128);
    std::fill(std::begin(sweep_counts),std::end(sweep_counts),0);
    parse_beatmap(&region->header,data.data(),data.data()+length);
    const auto &h=region->header;
    u64 widths[6]{},sliders=0,points=0,max_points=0,decimals=0,integers=0,long_lengths=0;
    for(u32 i=0;i<h.ELEM_COUNT[MEM_object_header];++i) {
      auto o=h.get_object_header()[i];unsigned digits=1;
      for(auto time=o.time;time>=10;time/=10)++digits;
      ++widths[digits<4?0:digits>7?5:digits-3];
      if(o.type&2) {
        ++sliders;auto b=h.get_object_body()[i];
        u64 count=b.point_start?b.point_end-b.point_start:0;points+=count;max_points=std::max(max_points,count);
      }
    }
    std::istringstream lines(std::string(data.data(),length));std::string line;bool objects=false;
    while(std::getline(lines,line)) {
      if(line=="[HitObjects]" || line=="[HitObjects]\r"){objects=true;continue;}
      if(!objects)continue;
      std::vector<std::string> fields;std::istringstream parts(line);std::string field;
      while(std::getline(parts,field,','))fields.push_back(field);
      if(fields.size()<8 || !(std::strtoul(fields[3].c_str(),nullptr,10)&2))continue;
      auto &v=fields[7];auto end=v.find_first_not_of("0123456789.");if(end!=std::string::npos)v.resize(end);
      (v.find('.')==std::string::npos?integers:decimals)++;long_lengths+=v.size()>16;
    }
    auto utf8=path.filename().u8string();std::string file(utf8.begin(),utf8.end());
    std::cout<<'"';for(char c:file){if(c=='"')std::cout<<'"';std::cout<<c;}std::cout<<"\",";
    const char *hex="0123456789abcdef";for(auto c:digest)std::cout<<hex[c>>4]<<hex[c&15];
    std::cout<<','<<length<<','<<h.version_number<<','<<h.ELEM_COUNT[MEM_object_header];
    for(auto n:widths)std::cout<<','<<n;
    std::cout<<','<<sliders<<','<<points<<','<<max_points<<','<<decimals<<','<<integers<<','<<long_lengths
      <<','<<sweep_counts[0]<<','<<sweep_counts[2]<<','<<sweep_counts[3]<<'\n';
  }
  BCryptCloseAlgorithmProvider(sha,0);
}
