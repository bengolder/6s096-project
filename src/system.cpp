#include <vector>
#include <cmath>
#include <iostream>
#include "nbody/system.hpp"

const double G  = 6.67300E-11;

void System::add_body(Body body) {
  _bodies.push_back(body);
}

double* System::compute_spatial_forces() {
  /* The array returned contains the forces
     according to the convention
     Fx1, Fy1, Fx2, Fy2... 
     where Fxi is the force felt by the object 
     i in the x direction */
  double* forces = (double*)malloc(_bodies.size()*2*sizeof(double));
  unsigned int i;
  unsigned int j;
  for (i=0;i<_bodies.size();i++) {
    double Fx = 0;
    double Fy = 0;
    for (j=0;j<_bodies.size();j++) {
      if (i!=j) {
	Body body1 = _bodies.at(i);
	Body body2 = _bodies.at(j);
	double dx = body2.x() - body1.x();
	double dy = body2.y() - body1.y();
	// there is the particular case of having both
	// bodies on top of each other. Since Newton is
	// is not defined in that case, we set the forces
	// to be 0.
	if (dx>0) {
	  Fx += G*(_bodies[i].mass()*_bodies[j].mass())/(dx*dx);
	}
	if (dy>0) {
	  Fy += G*(_bodies[i].mass()*_bodies[j].mass())/(dy*dy);
	}
      }
    }
    forces[2*i] = Fx;
    forces[2*i+1] = Fy;
  }
  return forces;
}

void System::update(const double dt) {
  double* forces = compute_spatial_forces();
  unsigned int i;
  for (i=0;i<_bodies.size();i++) {
    _bodies[i].update(forces[2*i],forces[2*i+1],dt);
  }
  free(forces);
}

void System::print() const {
  unsigned int i;
  std::cout << "System: \n";
  for (i=0;i<_bodies.size();i++) {
    _bodies[i].print();
  }
}
