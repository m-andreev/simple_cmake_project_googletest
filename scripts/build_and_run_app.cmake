cmake_minimum_required(VERSION 3.5)

# Build the project and run only the main application binary.
# This script does NOT run unit tests.

set(project_root "${CMAKE_CURRENT_LIST_DIR}/..")
get_filename_component(project_root "${project_root}" ABSOLUTE)
set(build_dir "${project_root}/build_gcc")

function(run_checked)
  string(JOIN " " cmd_str ${ARGV})
  message(STATUS "Running: ${cmd_str}")
  execute_process(
    COMMAND ${ARGV}
    RESULT_VARIABLE cmd_result
  )
  if(NOT cmd_result EQUAL 0)
    message(FATAL_ERROR "Command failed with exit code ${cmd_result}: ${cmd_str}")
  endif()
endfunction()

# Check required tools.
execute_process(COMMAND g++ --version RESULT_VARIABLE gpp_result OUTPUT_QUIET ERROR_QUIET)
if(NOT gpp_result EQUAL 0)
  message(FATAL_ERROR "g++ is not installed or not in PATH.")
endif()

execute_process(COMMAND cmake --version RESULT_VARIABLE cmake_result OUTPUT_QUIET ERROR_QUIET)
if(NOT cmake_result EQUAL 0)
  message(FATAL_ERROR "CMake is not installed or not in PATH.")
endif()

# Clean and recreate build directory.
if(EXISTS "${build_dir}")
  file(REMOVE_RECURSE "${build_dir}")
endif()
file(MAKE_DIRECTORY "${build_dir}")

# Configure with a generator based on platform.
if(WIN32)
  set(generator "MinGW Makefiles")
else()
  set(generator "Unix Makefiles")
endif()

message(STATUS "Configuring project with generator: ${generator}")
run_checked(
  cmake
  -G "${generator}"
  -DCMAKE_CXX_COMPILER=g++
  -DCMAKE_C_COMPILER=gcc
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5
  -S "${project_root}"
  -B "${build_dir}"
)

message(STATUS "Building project...")
run_checked(cmake --build "${build_dir}")

# Run the application only.
if(WIN32)
  set(app_exe "${build_dir}/src/hello_world.exe")
else()
  set(app_exe "${build_dir}/src/hello_world")
endif()

if(NOT EXISTS "${app_exe}")
  message(FATAL_ERROR "Application binary not found: ${app_exe}")
endif()

message(STATUS "Running application (no arguments)...")
execute_process(COMMAND "${app_exe}" RESULT_VARIABLE app_result)
if(NOT app_result EQUAL 0)
  message(FATAL_ERROR "Application run failed.")
endif()

message(STATUS "Running application (with argument 'Developer')...")
execute_process(COMMAND "${app_exe}" "Developer" RESULT_VARIABLE app_result2)
if(NOT app_result2 EQUAL 0)
  message(FATAL_ERROR "Application run failed with argument.")
endif()
