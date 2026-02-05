# Hello World C++ Project with CMake and Google Test

A simple C++ "Hello World" application demonstrating modern CMake practices and Google Test integration.

## Project Structure

```
simple_cmake_project_googletest/
├── CMakeLists.txt          # Root CMake configuration
├── README.md               # This file
├── build_and_run.bat       # Windows build script (g++)
├── build_and_run.sh        # Linux/macOS build script (g++)
├── scripts/                # Helper scripts (CMake)
│   ├── build_and_run_app.cmake # Cross-platform app-only script (g++)
│   ├── build_and_run_all.cmake # Cross-platform app + tests script (g++)
│   └── build_and_run_ut.cmake  # Cross-platform unit test script (g++)
├── build_gcc/              # Build directory (generated)
├── include/                # Header files
│   └── hello_world.h       # Hello World library header
├── src/                    # Source files
│   ├── CMakeLists.txt      # Source CMake configuration
│   ├── hello_world.cpp     # Hello World library implementation
│   └── main.cpp            # Main application
└── tests/                  # Test files
    ├── CMakeLists.txt      # Test CMake configuration
    └── test_hello_world.cpp # Google Test unit tests
```

## Prerequisites

Before building this project, ensure you have the following installed:

### 1. CMake (version 3.16 or higher)
- **Windows**: Download from [cmake.org](https://cmake.org/download/) or install via chocolatey:
  ```powershell
  choco install cmake
  ```
- **macOS**: Install via Homebrew:
  ```bash
  brew install cmake
  ```
- **Linux**: Install via package manager:
  ```bash
  sudo apt-get install cmake  # Ubuntu/Debian
  sudo yum install cmake      # CentOS/RHEL
  ```

### 2. g++ Compiler
- **Windows**: MinGW-w64 or MSYS2 with g++ (`https://www.msys2.org/`)
- **macOS**: Xcode command line tools (`xcode-select --install`) or Homebrew (`brew install gcc`)
- **Linux**: GCC (`sudo apt-get install g++` or `sudo yum install gcc-c++`)

### 3. Git (for Google Test download)
- Download from [git-scm.com](https://git-scm.com/) or install via package manager

## Building the Project

### Quick Start (Recommended)

**All platforms (CMake script):**
```bash
cmake -P scripts/build_and_run_app.cmake
```

**Legacy OS-specific scripts:**
```powershell
.\build_and_run.bat
```
```bash
./build_and_run.sh
```
These scripts build the app and unit test binaries, then run the app and the tests.

### Manual Build Process

1. **Clone or navigate to the project directory**:
   ```bash
   cd simple_cmake_project_googletest
   ```

2. **Create and navigate to build directory**:
   ```bash
   mkdir build_gcc
   cd build_gcc
   ```

3. **Configure the project with CMake using g++**:
   ```bash
   cmake -G "Unix Makefiles" -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc ..
   ```

   On Windows with MinGW:
   ```powershell
   cmake -G "MinGW Makefiles" -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc ..
   ```

4. **Build the project**:
   ```bash
   cmake --build .
   ```

## Running the Application

### Using Build Scripts (Recommended)

**All platforms (CMake script):**
```bash
cmake -P scripts/build_and_run_app.cmake   # Builds and runs the app only
```

**Legacy OS-specific scripts:**
```powershell
.\build_and_run.bat                # Builds app + tests, runs app and tests
```
```bash
./build_and_run.sh                 # Builds app + tests, runs app and tests
```

### Manual Execution

After building, you can run the Hello World application:

```bash
# From the build_gcc directory
./src/hello_world            # Linux/macOS
.\src\hello_world.exe        # Windows

# With a personalized message
./src/hello_world Alice      # Linux/macOS
.\src\hello_world.exe Alice  # Windows
```

Expected output:
```
Hello, World!
Also, Hello, Alice!
```

## Running Tests

### Using Build Scripts (Recommended)

**App + tests (CMake script):**
```bash
cmake -P scripts/build_and_run_all.cmake  # Builds project, runs app, runs tests
```

**Tests only (CMake script):**
```bash
cmake -P scripts/build_and_run_ut.cmake   # Builds and runs tests (GoogleTest binary only)
```

### Manual Test Execution

To run the unit tests:

```bash
# From the build_gcc directory
ctest                        # Run all tests
./tests/hello_world_tests    # Run tests directly (Linux/macOS)
.\tests\hello_world_tests.exe # Run tests directly (Windows)
```

The test suite includes:
- Basic message generation tests
- Personalized message tests
- Output verification tests
- Edge case handling (empty names, special characters)
- Parameterized tests for multiple inputs

## Features

### Hello World Library
- **getMessage()**: Returns the standard "Hello, World!" message
- **getPersonalizedMessage(name)**: Returns a personalized greeting
- **printMessage()**: Prints the standard message to stdout
- **printPersonalizedMessage(name)**: Prints a personalized message to stdout

### Modern C++ Practices
- C++17 standard
- Namespace organization
- Proper header guards
- Comprehensive documentation
- Const-correctness

### Modern CMake Practices
- Minimum CMake version specification
- Target-based configuration
- Proper library linking
- FetchContent for dependency management
- Separate build and source directories
- Cross-platform compatibility

### Testing
- Google Test framework integration
- Comprehensive unit test coverage
- Output capture testing
- Parameterized tests
- CTest integration

## Development

To add new features:
1. Add function declarations to `include/hello_world.h`
2. Implement functions in `src/hello_world.cpp`
3. Add corresponding tests in `tests/test_hello_world.cpp`
4. Rebuild and test

## Troubleshooting

- **CMake not found**: Ensure CMake is installed and in your PATH
- **Compiler errors**: Verify you have a C++17 compatible compiler
- **Google Test download fails**: Check your internet connection and Git installation
- **Build fails on Windows**: Try using Visual Studio Developer Command Prompt

## License

This project is provided as an educational example and is free to use and modify.
