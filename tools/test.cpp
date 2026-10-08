#include <windows.h>
#include <cassert>
#include <iostream>
#include <string>
#include <vector>
#include "parser_layout.h"
extern "C" _memory_region_new *memory_region_create(u32);
extern "C" void parse_beatmap(void *,const char *,const char *);
extern "C" uint64_t audit_parser_call(void *,const char *,const char *,void (*)(void *,const char *,const char *));
int main() {
  auto *memory=memory_region_create(0);assert(memory);
  unsigned cases=0;
  for(unsigned mode=0;mode<4;++mode)for(auto sound:{"0","15"})
  for(auto stack:{"0.25","0.75"})for(unsigned offset:{0u,1u,15u,31u}) {
    std::string input="osu file format v14\n\n[General]\nAudioFilename: test.mp3\nAudioLeadIn: 0\nMode: "+std::to_string(mode)+"\nStackLeniency: "+stack+"\n\n[Difficulty]\n\n[TimingPoints]\n0,500,4,2,1,100,1,0\n\n[HitObjects]\n";
    auto object=[&](unsigned time,const char *points,const char *length) {
      input+="256,192,"+std::to_string(time)+",2,"+sound+","+"BLPC"[mode]+"|"+points+",12,"+length+"\n";
    };
    object(50000,"30:20|40:30","100");
    object(50001,"-30:20|40:30","100");
    object(50002,"1234;56","100"); // Failure must not poison the next fallback.
    object(50003,"1234:56|78:9000","0.35");
    std::vector<char> bytes(64+offset+input.size()+128);
    auto *p=bytes.data()+64+offset;memcpy(p,input.data(),input.size());
    assert(audit_parser_call(&memory->header,p,p+input.size(),parse_beatmap)==0);
    const auto &h=memory->header;
    assert(h.osu_headers.Mode==mode);
    assert(h.osu_headers.table[1]==(stack[2]=='2'?0.25:0.75));
    assert(h.ELEM_COUNT[MEM_object_header]==3);
    for(unsigned i=0;i<3;++i) {
      const auto &s=h.get_object_body()[i];
      assert(h.get_object_header()[i].time==(i==2?50003:50000+i));
      assert(s.curve_type==unsigned("BLPC"[mode]) && s.slides==12);
      assert(s.point_end-s.point_start==2);
      assert(s.point_start[0].x==(i==0?30:i==1?-30:1234));
      assert(s.point_start[0].y==(i==2?56:20));
      assert(s.point_start[1].x==(i==2?78:40));
      assert(s.point_start[1].y==(i==2?9000:30));
      uint64_t bits;memcpy(&bits,&s.length,8);
      assert(bits==(i==2?0x3fd6666666666667ull:0x4059000000000000ull));
    }
    ++cases;
  }
  std::cout<<"passed "<<cases<<" cases\n";
}
