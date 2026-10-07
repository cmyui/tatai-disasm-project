#pragma once
#include <ostream>
#include "parser_layout.h"

// Serialize fields the reference parser writes. Pointers, padding and unwritten
// spinner bodies are excluded; parse_spinner is not called by the reference.
struct Output {
  std::ostream &stream;
  explicit Output(std::ostream &output) : stream(output) {}
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
      }
    }
    u32 timing=h.ELEM_COUNT[MEM_timing_point];field(timing);
    for(u32 i=0;i<timing;++i) {
      const auto &t=h.get_timing_point()[i];field(t.time);field(t.beat_length);field(t.tick_beat_length);
    }
  }
};

