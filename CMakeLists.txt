cmake_minimum_required(VERSION 3.5)

# Project configuration
project(HelloWorldApp 
    VERSION 1.0.0
    DESCRIPTION "A simple Hello World application with Google Test"
    LANGUAGES CXX
)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
if(MINGW)
    # Use GNU extensions on MinGW to avoid __STRICT_ANSI__ hiding needed APIs in old headers
    set(CMAKE_CXX_EXTENSIONS ON)
else()
    set(CMAKE_CXX_EXTENSIONS OFF)
endif()

# Set default build type to Release if not specified
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# Compiler-specific options
if(MSVC)
    add_compile_options(/W4)
else()
    add_compile_options(-Wall -Wextra -Wpedantic)
    # Fix for older MinGW versions
    if(MINGW)
        add_compile_definitions(_WIN32_WINNT=0x0601)  # Windows 7 API level
        add_compile_options(-pthread)
    endif()
endif()

# Include directories
include_directories(include)

# Add subdirectories
add_subdirectory(src)

# Enable testing and add tests subdirectory
enable_testing()
add_subdirectory(tests)

# Print build information
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "C++ standard: ${CMAKE_CXX_STANDARD}")
message(STATUS "Compiler: ${CMAKE_CXX_COMPILER_ID}")
