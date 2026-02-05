#ifndef HELLO_WORLD_H
#define HELLO_WORLD_H

#include <string>

/**
 * @brief A simple Hello World library
 * 
 * This library provides functionality to generate and display
 * Hello World messages in various formats.
 */
namespace HelloWorld {

    /**
     * @brief Get the standard Hello World message
     * @return std::string containing "Hello, World!"
     */
    std::string getMessage();

    /**
     * @brief Get a personalized Hello message
     * @param name The name to include in the greeting
     * @return std::string containing "Hello, [name]!"
     */
    std::string getPersonalizedMessage(const std::string& name);

    /**
     * @brief Print the Hello World message to stdout
     */
    void printMessage();

    /**
     * @brief Print a personalized Hello message to stdout
     * @param name The name to include in the greeting
     */
    void printPersonalizedMessage(const std::string& name);

} // namespace HelloWorld

#endif // HELLO_WORLD_H
