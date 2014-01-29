#include <vector>
#include "nbody/body.hpp"

class System {
  std::vector<Body> _bodies;
public:
  System(): _bodies{std::vector<Body>()} {};
  
  std::vector<Body> bodies() const { return _bodies; }

  double* compute_spatial_forces();
  void add_body(Body body);
  void update(const double dt);
  void print() const;
};
