# Assembly functions

| Module | Entry point | Source declaration |
|---|---|---|
| `runtime.s` | `shared_ptr_dispose` | `std::_Sp_counted_ptr<decltype(nullptr), (__gnu_cxx::_Lock_policy)2>::_M_dispose()` |
| `runtime.s` | `shared_ptr_destroy` | `std::_Sp_counted_base<(__gnu_cxx::_Lock_policy)2>::_M_destroy()` |
| `runtime.s` | `codecvt_decode` | `std::__codecvt_abstract_base<wchar_t, char, _Mbstatet>::in(_Mbstatet&, char const*, char const*, char const*&, wchar_t*, wchar_t*, wchar_t*&) const` |
| `runtime.s` | `codecvt_destroy` | `std::codecvt_utf8_utf16<wchar_t, 1114111ul, (std::codecvt_mode)0>::~codecvt_utf8_utf16()` |
| `runtime.s` | `codecvt_delete` | `std::codecvt_utf8_utf16<wchar_t, 1114111ul, (std::codecvt_mode)0>::~codecvt_utf8_utf16()` |
| `runtime.s` | `path_codecvt_destroy` | `std::filesystem::__cxx11::path::_Codecvt<wchar_t>::~_Codecvt()` |
| `runtime.s` | `path_codecvt_delete` | `std::filesystem::__cxx11::path::_Codecvt<wchar_t>::~_Codecvt()` |
| `benchmark.s` | `sort_timings` | `void std::__introsort_loop<__gnu_cxx::__normal_iterator<double*, std::vector<double, std::allocator<double> > >, long long, std::less<void> >(__gnu_cxx::__normal_iterator<double*, std::vector<double, std::allocator<double> > >, __gnu_cxx::__normal_iterator<double*, std::vector<double, std::allocator<double> > >, long long, std::less<void>) [clone .isra.0]` |
| `sliders.s` | `slider_type_valid` | `is_valid_slider_type(unsigned int)` |
| `memory.s` | `memory_commit` | `byte_allocator::commit_memory(void*, unsigned long long)` |
| `memory.s` | `memory_resize` | `byte_allocator::NOINLINE_resize(unsigned long long, void*, unsigned int&)` |
| `memory.s` | `memory_region_create` | `create_memory_region(unsigned int)` |
| `deferrals.s` | `defer_object_header` | `push_error_object_header_list(char const*, _object_header*)` |
| `deferrals.s` | `defer_slider_body` | `push_error_slider_body_list(_slider_data*)` |
| `object_headers.s` | `parse_object_5digit` | `parse_5_time::NO_INLINE_parse_object_5digit_single(char const*, _object_header*)` |
| `object_headers.s` | `parse_object_6digit` | `parse_6_time::NO_INLINE_parse_object_6digit_single(char const*, _object_header*)` |
| `sliders.s` | `parse_slider_negative` | `slider_body_neg::parse_slider_point_negative(char const*, _slider_point*, unsigned int, unsigned int)` |
| `decimals.s` | `parse_decimal` | `parse_double::from_ascii::NO_INLINE_parse_decimal_16(char const*)` |
| `spinners.s` | `parse_spinner` | `parse_spinner(char const*)` |
| `sliders.s` | `parse_slider_general` | `general_parse_slider_points(char const*, _slider_point*, _slider_data*)` |
| `beatmap.s` | `find_hitobjects` | `find_hitobjects_line(char const*, char const*)` |
| `runtime.s` | `path_destroy` | `std::filesystem::__cxx11::path::~path()` |
| `runtime.s` | `throw_path_conversion_error` | `std::filesystem::__cxx11::__detail::__throw_conversion_error()` |
| `runtime.s` | `shared_ptr_release_cold` | `std::_Sp_counted_base<(__gnu_cxx::_Lock_policy)2>::_M_release_last_use_cold()` |
| `runtime.s` | `shared_ptr_release` | `std::_Sp_counted_base<(__gnu_cxx::_Lock_policy)2>::_M_release()` |
| `headers.s` | `parse_timing_points_v14` | `char const** parse_timing_points<true>(_memory_region_header*, char const**, char const**)` |
| `headers.s` | `parse_timing_points_legacy` | `char const** parse_timing_points<false>(_memory_region_header*, char const**, char const**)` |
| `headers.s` | `parse_beatmap_header` | `parse_beatmap_header(_memory_region_header*, char const**, char const**)` |
| `object_loop.s` | `parse_objects_4digit` | `_Z17parse_object_loopITnDaXadL_ZN12parse_4_time26parse_object_4digit_singleEPKcP14_object_headerEEEyPKS2_S4_P12_slider_dataP16_slider_deferral` |
| `object_loop.s` | `parse_objects_5digit_context` | `_Z17parse_object_loopITnDaXadL_ZN12parse_5_time26parse_object_5digit_singleEPKcP14_object_headerEEEyPKS2_S4_P12_slider_dataP16_slider_deferral` |
| `object_loop.s` | `parse_objects_6digit_context` | `_Z17parse_object_loopITnDaXadL_ZN12parse_6_time26parse_object_6digit_singleEPKcP14_object_headerEEEyPKS2_S4_P12_slider_dataP16_slider_deferral` |
| `object_loop.s` | `parse_objects_7digit` | `_Z17parse_object_loopITnDaXadL_ZN12parse_7_time26parse_object_7digit_singleEPKcP14_object_headerEEEyPKS2_S4_P12_slider_dataP16_slider_deferral` |
| `beatmap.s` | `parse_beatmap_body` | `parse_beatmap_from_memory(_memory_region_header*, char const*, char const*) [clone .part.0]` |
| `beatmap.s` | `parse_beatmap` | `parse_beatmap_from_memory(_memory_region_header*, char const*, char const*)` |
| `runtime.s` | `path_convert_utf8` | `auto std::filesystem::__cxx11::path::_S_convert<char>(char const*, char const*)` |
| `file_io.s` | `read_file_into` | `read_file2(char const*, std::vector<unsigned char, std::allocator<unsigned char> >&)` |
| `benchmark.s` | `benchmark_folder` | `run_test_folder()` |
| `file_io.s` | `read_file` | `read_file(char const*)` |
| `benchmark.s` | `benchmark_preloaded` | `run_test_prebatch()` |
| `benchmark.s` | `main` | `main` |
| `line_scan.s` | `refill_object_lines` | Assembly-only bounded hit-object line scan |
