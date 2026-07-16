target_compile_definitions(demo PRIVATE
  $<$<CONFIG:Debug>:DEBUG_BUILD>
  $<$<CXX_COMPILER_ID:GNU>:GNU_COMPILER>
)

target_include_directories(demo PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include>
)

add_custom_command(TARGET demo POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E echo "$<TARGET_FILE:demo>"
)
