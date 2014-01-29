#include <vector>
#include "nbody/body.hpp"

class System {
  std::vector<Body> _bodies;
public:
  System(): _bodies{std::vector<Body>()} {};
  
  std::vector<Body> bodies() const { return _bodies; }

  std::vector<std::vector<double>> compute_spatial_forces() const {}
  void add_body(Body body);
  void update(const double dt);
  void print() const;
};
