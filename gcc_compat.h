#pragma once
#include <algorithm>
#include <cstdint>
#include <cstring>
#ifndef __assume
#define __assume(condition) do { if (!(condition)) __builtin_unreachable(); } while (0)
#endif
inline unsigned long long _shlx_u64(unsigned long long value, unsigned int shift) {
  return value << (shift & 63u);
}
