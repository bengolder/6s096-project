#include <cstdlib>
#include <cmath>
#include <iostream>
#include "nbody/body.hpp"

void Body::update(const double Fx, const double Fy, const double dt){
  // Integration using forward euler's method
  _x += _dx*dt; // deltaposition = velocity*deltatime
  _y += _dy*dt;
  _dx += Fx/_mass; // F=ma, deltavelocity=acceleration*deltatime
  _dy += Fy/_mass;
}

double Body::velocity() const {
  double vel = sqrt(pow(_dx,2)+pow(_dy,2));
  return vel;
}

void Body::print() const {
  std::cout << "Body: mass=" << _mass << " x=" << _x << " y=" 
	    << _y << " dx=" << _dx << " dy=" 
	    << _dy << " velocity=" << velocity() << "\n";
}
