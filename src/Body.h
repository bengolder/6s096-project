//
//  Body.h
//  OpenGL_Test
//
//  Created by j_duro on 1/30/14.
//  Copyright (c) 2014 j_duro. All rights reserved.
//

#ifndef __OpenGL_Test__Body__
#define __OpenGL_Test__Body__

#include <iostream>
class Body {
    double _mass; // kilograms
    double _x;  // meters
    double _y;
    double _z;
    //double _dx;  // meters per seconds
    //double _dy;
public:
    
    Body(double mm, double xx, double yy, double zz): _mass{mm}, _x{xx}, _y{yy}, _z{zz} {}
    
    Body(): _mass{0}, _x{0}, _y{0}, _z{0} {}
    
    Body(const double m): _mass{m}, _x{0}, _y{0}, _z{0} {} //_dx{0}, _dy{0} {}
    
    double mass() const { return _mass; }
    void mass(const double& m) { _mass=m; }
    double x() const { return _x; }
    void x(const double& new_x) { _x=new_x; }
    double y() const { return _y; }
    void y(const double& new_y) { _y=new_y; }
    double z() const { return _z; }
    void z(const double& new_z) { _z=new_z; }
    
    //double dx() const { return _dx; }
    //void dx(const double& new_dx) { _dx=new_dx; }
    //double dy() const { return _dy; }
    //void dy(const double& new_dy) { _dy=new_dy; }
    
    // Takes a force (in Newtons) as input and updates the state
    //void update(const double Fx, const double Fy, const double dt);
    //double velocity() const;
    //void print() const;
};
#endif /* defined(__OpenGL_Test__Body__) */
