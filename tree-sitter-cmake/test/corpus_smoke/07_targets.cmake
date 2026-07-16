target_link_libraries(demo
  PRIVATE demolib
  PUBLIC Threads::Threads
  INTERFACE header_only_lib
)

target_include_directories(demolib PRIVATE ${CMAKE_SOURCE_DIR}/include)

target_compile_options(demo PRIVATE -Wall -Wextra)

set_target_properties(demo PROPERTIES
  CXX_STANDARD 20
  OUTPUT_NAME "demo-app"
)
