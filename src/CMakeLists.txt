# Create the Hello World library
add_library(hello_world_lib
    hello_world.cpp
)

# Set target properties for the library
target_include_directories(hello_world_lib
    PUBLIC ${CMAKE_SOURCE_DIR}/include
)

# Create the main executable
add_executable(hello_world_app
    main.cpp
)

# Link the library to the executable
target_link_libraries(hello_world_app
    PRIVATE hello_world_lib
)

# Set target properties for the executable
set_target_properties(hello_world_app PROPERTIES
    OUTPUT_NAME "hello_world"
)
