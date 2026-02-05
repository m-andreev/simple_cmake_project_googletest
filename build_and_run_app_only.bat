@echo off
REM Build and run application-only script for Windows using g++ (MinGW/MSYS2)

echo Building and Running Hello World C++ Project (app only) with g++...

REM Check if g++ is available
g++ --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: g++ is not installed or not in PATH
    echo Please install MinGW-w64 or MSYS2 with g++
    echo Download from: https://www.msys2.org/ or https://www.mingw-w64.org/
    pause
    exit /b 1
)

REM Check if CMake is available
cmake --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: CMake is not installed or not in PATH
    echo Please install CMake from https://cmake.org/download/
    pause
    exit /b 1
)

REM Clean and create build directory
if exist build_gcc (
    echo Cleaning previous build...
    rmdir /s /q build_gcc
)
mkdir build_gcc
cd build_gcc

REM Configure the project with g++ generator
echo Configuring project with CMake using MinGW Makefiles...
cmake -G "MinGW Makefiles" -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc -DCMAKE_POLICY_VERSION_MINIMUM=3.5 ..
if %errorlevel% neq 0 (
    echo ERROR: CMake configuration failed
    pause
    exit /b 1
)

REM Build only the application target (no unit tests)
echo Building application target only...
cmake --build . --target hello_world_app
if %errorlevel% neq 0 (
    echo ERROR: Build failed
    pause
    exit /b 1
)

echo.
echo Build completed successfully with g++!
echo.
echo Running the Hello World application:
echo =====================================

REM Run the application without arguments
echo.
echo 1. Running without arguments:
.\src\hello_world.exe
if %errorlevel% neq 0 (
    echo ERROR: Failed to run hello_world.exe
    pause
    exit /b 1
)

REM Run the application with a name argument
echo.
echo 2. Running with argument "Developer":
.\src\hello_world.exe Developer
if %errorlevel% neq 0 (
    echo ERROR: Failed to run hello_world.exe with argument
    pause
    exit /b 1
)

echo.
echo =====================================
echo Application ran successfully with g++!
echo.

pause
