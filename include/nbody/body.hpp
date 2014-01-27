
namespace nbody {
  class Body {
    // state = < x, y, dx, dy >
    vector _state;
    double _mass;
    public:
    Body();
    ~Body();
    
    const void velocity() {};
    const void mass() {};
    void &mass( vector mass ) {};
    const void printBody() {};
  };
}
