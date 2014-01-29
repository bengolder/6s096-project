#include <vector>
#include <cmath>
#include <iostream>
#include "nbody/system.hpp"

const double G  = 6.67300E-11;

void System::add_body(Body body) {
  _bodies.push_back(body);
}

std::vector<std::vector<double>> System::compute_spatial_forces() const {
  std::vector<std::vector<double>> forces;
  int i;
  int j;
  for (i=0;i<_bodies.size();i++){
    double Fx = 0;
    double Fy = 0;
    for (j=0;j<_bodies.size();j++) {
      if (i!=j) {
	Fx += G*(_bodies[i].mass()*_bodies[j].mass())/exp(_bodies[i].x()-_bodies[j].x(),2);
        Fy += G*(_bodies[i].mass()*_bodies[j].mass())/exp(_bodies[i].y()-_bodies[j].y(),2);
      }
    }
    std::vector<double> force = std::vector<double>();
    force.push_back(Fx);
    force.push_back(Fy);
    forces.push_back(force);
  }
  return forces;
}

void System::update(const double dt) {
  std::vector<std::vector<double>> forces = compute_spatial_forces();
  int i;
  for (i=0;i<_bodies.size();i++) {
    _bodies[i].update(forces[i][0],forces[i][1],dt);
  }
}

void System::print() const {
  int i;
  std::cout << "System: \n";
  for (i=0;i<_bodies.size();i++) {
    _bodies[i].print();
  }
}
