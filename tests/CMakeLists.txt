# Include FetchContent module for downloading Google Test
include(FetchContent)

# Fetch Google Test
FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG        release-1.8.1  # Compatible with older CMake and MinGW versions
)

# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

# Make Google Test available
FetchContent_MakeAvailable(googletest)

# Create test executable
add_executable(hello_world_tests
    test_hello_world.cpp
)

# Link test executable with Google Test and our library
target_link_libraries(hello_world_tests
    PRIVATE
    hello_world_lib
    gtest_main
    gtest
)

# Include directories for tests
target_include_directories(hello_world_tests
    PRIVATE ${CMAKE_SOURCE_DIR}/include
)

# Enable testing with CTest
include(GoogleTest)
gtest_discover_tests(hello_world_tests)
