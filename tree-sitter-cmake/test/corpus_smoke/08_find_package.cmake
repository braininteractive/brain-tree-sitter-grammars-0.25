find_package(Threads REQUIRED)
find_package(Boost 1.75 COMPONENTS filesystem system)
find_package(OpenSSL QUIET)

if(OpenSSL_FOUND)
  target_link_libraries(demo PRIVATE OpenSSL::SSL OpenSSL::Crypto)
endif()

include(FetchContent)
FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG v1.14.0
)
FetchContent_MakeAvailable(googletest)
