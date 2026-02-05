#!/bin/bash

# Build and run script using g++

echo "Building and Running Hello World C++ Project with g++..."

# Check if g++ is available
if ! command -v g++ &> /dev/null; then
    echo "ERROR: g++ is not installed or not in PATH"
    echo "Please install g++:"
    echo "  Ubuntu/Debian: sudo apt-get install g++"
    echo "  macOS: xcode-select --install (or brew install gcc)"
    echo "  CentOS/RHEL: sudo yum install gcc-c++"
    exit 1
fi

# Check if CMake is available
if ! command -v cmake &> /dev/null; then
    echo "ERROR: CMake is not installed or not in PATH"
    echo "Please install CMake:"
    echo "  Ubuntu/Debian: sudo apt-get install cmake"
    echo "  macOS: brew install cmake"
    echo "  CentOS/RHEL: sudo yum install cmake"
    exit 1
fi

# Clean and create build directory
if [ -d "build_gcc" ]; then
    rm -rf build_gcc
fi
mkdir build_gcc
cd build_gcc

# Configure the project with g++
echo "Configuring project with CMake using Unix Makefiles and g++..."
cmake -G "Unix Makefiles" -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc -DCMAKE_POLICY_VERSION_MINIMUM=3.5 ..
if [ $? -ne 0 ]; then
    echo "ERROR: CMake configuration failed"
    exit 1
fi

# Build the project (app + unit tests)
echo "Building project with g++ (app + unit tests)..."
cmake --build . --target hello_world_app hello_world_tests
if [ $? -ne 0 ]; then
    echo "ERROR: Build failed"
    exit 1
fi

echo ""
echo "Build completed successfully with g++!"
echo ""
echo "Running the Hello World application:"
echo "====================================="

# Run the application without arguments
echo ""
echo "1. Running without arguments:"
./src/hello_world
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to run hello_world"
    exit 1
fi

# Run the application with a name argument
echo ""
echo "2. Running with argument \"Developer\":"
./src/hello_world Developer
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to run hello_world with argument"
    exit 1
fi

echo ""
echo "====================================="
echo "Application ran successfully with g++!"
echo ""
echo "Running unit tests (GoogleTest binary):"
echo "======================================"

# Run the unit test binary directly
echo ""
echo "3. Running unit tests:"
./tests/hello_world_tests
if [ $? -ne 0 ]; then
    echo "ERROR: Unit tests failed"
    exit 1
fi

echo ""
echo "====================================="
echo "Application and unit tests ran successfully with g++!"
echo ""
