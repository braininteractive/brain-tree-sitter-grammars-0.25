option(BUILD_TESTS "Build the test suite" ON)

install(TARGETS demo demolib
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)

install(DIRECTORY include/ DESTINATION include)

add_custom_target(docs
  COMMAND doxygen ${CMAKE_SOURCE_DIR}/Doxyfile
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
  COMMENT "Generating documentation"
)

configure_file(config.h.in config.h @ONLY)
