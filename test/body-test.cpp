#include <iostream>
#include <nbody/body.hpp>

int main() {

  std::cout << "Body test:\n";
  Body body = Body(5);
  body.print();

  return 0;
}
