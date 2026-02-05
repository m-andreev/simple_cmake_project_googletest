#include "hello_world.h"
#include <iostream>
#include <string>

int main(int argc, char* argv[]) {
    // Print the standard Hello World message
    HelloWorld::printMessage();
    
    // If a name is provided as command line argument, print personalized message
    if (argc > 1) {
        std::string name = argv[1];
        std::cout << "Also, ";
        HelloWorld::printPersonalizedMessage(name);
    }
    
    return 0;
}
