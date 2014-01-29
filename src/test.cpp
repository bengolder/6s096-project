#include <iostream>
#include "nbody/body.hpp"
#include "nbody/system.hpp"

int main() {

  std::cout << "Body test:\n";
  Body body = Body(5);
  body.print();

  std::cout << "System test:\n";
  System system = System();
  Body body1 = Body(10);
  Body body2 = Body(15);
  Body body3 = Body(17);
  system.add_body(body1);
  system.add_body(body2);
  system.add_body(body3);
  system.print();

  std::cout << "Taking one step forward in time:\n";
  system.update(0.01);
  system.print();

  return 0;
}
