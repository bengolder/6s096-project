#include <iostream>
#include <nbody/system.hpp>

int main() {

  std::cout << "System test:\n";
  System system = System();
  Body body1 = Body(10);
  Body body2 = Body(15);
  body2.x(5);
  Body body3 = Body(17);
  body3.y(10);
  system.add_body(body1);
  system.add_body(body2);
  system.add_body(body3);
  system.print();

  std::cout << "Taking one step forward in time:\n";
  system.update(0.01);
  system.print();

  std::cout << "Making 10 more steps forward...\n";
  int i;
  for (i=0;i<10;i++) {
    system.update(0.0001);
  }
  system.print();

  return 0;
}
