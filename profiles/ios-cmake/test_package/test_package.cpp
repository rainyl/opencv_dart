#include <iostream>

int add(int a, int b){
    return a + b;
}

int main(int argc, const char** argv) {
    int c = add(1, 2);
    std::cout << "1+2=" << c << std::endl;
    return 0;
}
