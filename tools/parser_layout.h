#pragma once
#include <cstdint>
#include <cstring>
#include <cstdio>
using u8=uint8_t; using u32=uint32_t; using u64=uint64_t;
struct _slider_point {
  int x;
  int y;
};

struct alignas(16) _object_header {
  u32 x, y;
  u32 time;
  u32 type; // hit sound data will be blitted here afterwards
};

struct _error_entry {
  const char *line;
  _object_header *object;
};

struct alignas(16) _object_header_error {
  _error_entry *error_out;
  u32 error_count;
  u32 ALLOC_error_out;
};

static_assert(sizeof(_object_header_error) == sizeof(_object_header));

struct _spinner_data {
  u32 end_time;
};

struct _slider_data {

  /*const*/ _slider_point *point_start, *point_end;
  double length;
  u32 slides;
  u32 curve_type;
};

struct _object_body {

  union {

    _slider_data slider;
    _spinner_data spinner;
  };
};
static_assert(sizeof(_object_body) == 32);

struct _slider_deferral {
  const char *p;
  _slider_data *out;
};

struct _timing_point {
  double beat_length, tick_beat_length;
  u32 time;
};

constexpr u64 MEMORY_REGION_SIZE{512ull * 1024ull * 1024ull};
constexpr u64 MEMORY_CHUNK_SIZE = 512ull * 1024ull; // 512kb - 128 pages of 4k

enum parse_flags : u32 {

  PARSE_FULL_HEADER = 1 << 1,
  PARSE_VALIDATE_TIME = 1 << 2,
  PARSE_NO_PRE_ALLOC = 1 << 3,

};

enum memory_region_enum : u64 {

  MEM_header = 0,

  MEM_lines,

  MEM_object_header,
  MEM_object_body,

  MEM_timing_point,

  MEM_slider_defer,
  MEM_slider_path,

  MEM_object_fallback,
  MEM_slider_fallback,

  MEM_REGION_COUNT
};

struct _memory_region_header {

  __forceinline const char **get_lines() const noexcept {
    return (const char **)((u8 *)this + MEMORY_REGION_SIZE * MEM_lines);
  }
  __forceinline _object_header *get_object_header() const noexcept {
    return (_object_header *)((u8 *)this +
                              MEMORY_REGION_SIZE * MEM_object_header);
  }
  __forceinline _slider_data *get_object_body() const noexcept {
    return (_slider_data *)((u8 *)this + MEMORY_REGION_SIZE * MEM_object_body);
  }
  __forceinline _timing_point *get_timing_point() const noexcept {
    return (_timing_point *)((u8 *)this +
                             MEMORY_REGION_SIZE * MEM_timing_point);
  }
  __forceinline _slider_deferral *get_slider_defer() const noexcept {
    return (_slider_deferral *)((u8 *)this +
                                MEMORY_REGION_SIZE * MEM_slider_defer);
  }
  __forceinline _slider_point *get_slider_path() const noexcept {
    return (_slider_point *)((u8 *)this + MEMORY_REGION_SIZE * MEM_slider_path);
  }
  __forceinline _error_entry *get_slider_fallback() const noexcept {
    return (_error_entry *)((u8 *)this +
                            MEMORY_REGION_SIZE * MEM_slider_fallback);
  }

  u32 ALLOC_COUNTS[MEM_REGION_COUNT];

  u32 ELEM_COUNT[MEM_REGION_COUNT]; // this isnt always kept up to date, at
                                    // least for now

  u32 version_number;

  u32 compile_flags;

  struct {

    double table[8];
    // double StackLeniency;
    u32 Mode;

  } osu_headers;

  u8 lines_skipped;

  void remove_invalid_lines() {

    u32 note_count{ELEM_COUNT[MEM_object_header]};

    auto *obj = get_object_header();
    auto *slider = get_object_body();

    for (size_t i{}; i < note_count; ++i) {

      if (0 == (obj[i].time == u32(-1) ||
                ((obj[i].type & 2) && slider[i].point_start == nullptr)))
        continue;

      std::memmove(obj + i, obj + i + 1, (note_count - i - 1) * sizeof(*obj));
      std::memmove(slider + i, slider + i + 1,
                   (note_count - i - 1) * sizeof(*slider));

      --i;
      --note_count;
    }

    ELEM_COUNT[MEM_object_header] = note_count;
  }

  void print_map_data() {

    _object_header *o{get_object_header()};
    _slider_data *s{get_object_body()};

    for (size_t i{}, size{ELEM_COUNT[MEM_object_header]}; i < size; ++i) {

      printf("%i> %i,%i | %i  ", o[i].time, o[i].x, o[i].y, o[i].type);

      if (o[i].type & 2) {

        printf("\n  %i %f  ", s[i].slides, s[i].length);
        const auto *p{s[i].point_start};
        for (; p != s[i].point_end; ++p) {
          printf("%i:%i|", p->x, p->y);
        }
      }

      printf("\n");
    }

    printf("NOTE_COUNT: %i\n", ELEM_COUNT[MEM_object_header]);
  }
};

struct _memory_region_new {

  _memory_region_header header;

  u8 padding0[4096 - sizeof(_memory_region_header)];
};
static_assert(sizeof(_memory_region_new) == 4096);

