#include <vector>
#include "body.hpp"

namespace nbody {
  class System {
    std::vector<Body> _bodies;
  public:
    System();
    ~System();

    vector<Body> bodies() const { return _bodies; }

    void update(const double dt) {}
  };
}
