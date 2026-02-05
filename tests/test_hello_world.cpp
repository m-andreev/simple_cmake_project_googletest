#include <gtest/gtest.h>
#include "hello_world.h"
#include <sstream>
#include <iostream>

// Test fixture for Hello World tests
class HelloWorldTest : public ::testing::Test {
protected:
    void SetUp() override {
        // Redirect cout to capture output for testing print functions
        original_cout_buffer = std::cout.rdbuf();
        std::cout.rdbuf(captured_output.rdbuf());
    }

    void TearDown() override {
        // Restore original cout
        std::cout.rdbuf(original_cout_buffer);
    }

    std::string getCapturedOutput() {
        std::string output = captured_output.str();
        captured_output.str("");  // Clear the buffer
        captured_output.clear();
        return output;
    }

private:
    std::ostringstream captured_output;
    std::streambuf* original_cout_buffer;
};

// Test the basic getMessage function
TEST_F(HelloWorldTest, GetMessageReturnsCorrectString) {
    std::string result = HelloWorld::getMessage();
    EXPECT_EQ(result, "Hello, World!");
}

// Test the personalized message function with a valid name
TEST_F(HelloWorldTest, GetPersonalizedMessageWithValidName) {
    std::string result = HelloWorld::getPersonalizedMessage("Alice");
    EXPECT_EQ(result, "Hello, Alice!");
}

// Test the personalized message function with an empty name
TEST_F(HelloWorldTest, GetPersonalizedMessageWithEmptyName) {
    std::string result = HelloWorld::getPersonalizedMessage("");
    EXPECT_EQ(result, "Hello, World!");
}

// Test the personalized message function with a name containing spaces
TEST_F(HelloWorldTest, GetPersonalizedMessageWithSpacesInName) {
    std::string result = HelloWorld::getPersonalizedMessage("John Doe");
    EXPECT_EQ(result, "Hello, John Doe!");
}

// Test the personalized message function with special characters
TEST_F(HelloWorldTest, GetPersonalizedMessageWithSpecialCharacters) {
    std::string result = HelloWorld::getPersonalizedMessage("José-María");
    EXPECT_EQ(result, "Hello, José-María!");
}

// Test the printMessage function
TEST_F(HelloWorldTest, PrintMessageOutputsCorrectString) {
    HelloWorld::printMessage();
    std::string output = getCapturedOutput();
    EXPECT_EQ(output, "Hello, World!\n");
}

// Test the printPersonalizedMessage function with a valid name
TEST_F(HelloWorldTest, PrintPersonalizedMessageWithValidName) {
    HelloWorld::printPersonalizedMessage("Bob");
    std::string output = getCapturedOutput();
    EXPECT_EQ(output, "Hello, Bob!\n");
}

// Test the printPersonalizedMessage function with an empty name
TEST_F(HelloWorldTest, PrintPersonalizedMessageWithEmptyName) {
    HelloWorld::printPersonalizedMessage("");
    std::string output = getCapturedOutput();
    EXPECT_EQ(output, "Hello, World!\n");
}

// Test that getMessage is consistent across multiple calls
TEST_F(HelloWorldTest, GetMessageConsistency) {
    std::string result1 = HelloWorld::getMessage();
    std::string result2 = HelloWorld::getMessage();
    EXPECT_EQ(result1, result2);
}

// Test that personalized messages work with various input types
TEST_F(HelloWorldTest, GetPersonalizedMessageWithNumbers) {
    std::string result = HelloWorld::getPersonalizedMessage("User123");
    EXPECT_EQ(result, "Hello, User123!");
}

// Parameterized test for multiple names
class HelloWorldParameterizedTest : public ::testing::TestWithParam<std::pair<std::string, std::string>> {
};

TEST_P(HelloWorldParameterizedTest, GetPersonalizedMessageParameterized) {
    auto param = GetParam();
    std::string input = param.first;
    std::string expected = param.second;
    
    std::string result = HelloWorld::getPersonalizedMessage(input);
    EXPECT_EQ(result, expected);
}

INSTANTIATE_TEST_CASE_P(
    VariousNames,
    HelloWorldParameterizedTest,
    ::testing::Values(
        std::make_pair("Alice", "Hello, Alice!"),
        std::make_pair("Bob", "Hello, Bob!"),
        std::make_pair("Charlie", "Hello, Charlie!"),
        std::make_pair("", "Hello, World!"),
        std::make_pair("123", "Hello, 123!")
    )
);


