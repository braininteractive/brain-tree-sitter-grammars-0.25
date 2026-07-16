cmake_minimum_required(VERSION 3.20)

project(demo VERSION 1.2.3 LANGUAGES C CXX)

add_executable(demo src/main.cpp src/util.cpp)

add_library(demolib STATIC src/lib.cpp)

add_library(demoshared SHARED src/shared.cpp)

target_compile_features(demo PRIVATE cxx_std_17)
