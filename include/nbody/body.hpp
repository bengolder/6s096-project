namespace nbody {
  typedef struct state_s {
    double x;
    double y;
    double dx; // x velocity
    double dy; // y velocity
  } state;

  class Body {
    state _state;
    double _mass; // in kg
  public:
    Body();
    ~Body();
    
    double mass() const { return _mass; }
    void mass(const double& mass) { _mass=mass; }
    
    state state() const { return _state; }

    // Takes a force (in Newtons) as input and updates the state 
    void update(const double Fx, const double Fy, const double dt);
    double velocity() const;
    void printBody() const;
  };
}
