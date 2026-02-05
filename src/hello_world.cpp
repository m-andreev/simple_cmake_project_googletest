#include "hello_world.h"
#include <iostream>

namespace HelloWorld {

    std::string getMessage() {
        return "Hello, World!";
    }

    std::string getPersonalizedMessage(const std::string& name) {
        if (name.empty()) {
            return getMessage();
        }
        return "Hello, " + name + "!";
    }

    void printMessage() {
        std::cout << getMessage() << std::endl;
    }

    void printPersonalizedMessage(const std::string& name) {
        std::cout << getPersonalizedMessage(name) << std::endl;
    }

} // namespace HelloWorld
