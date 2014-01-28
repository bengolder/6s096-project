class Body {
  double _mass; // kilograms
  double _x;  // meters
  double _y;
  double _dx;  // meters per seconds
  double _dy;
public:
  Body(const double m): _mass{m}, _x{0}, _y{0}, _dx{0}, _dy{0} {}
  
  double mass() const { return _mass; }
  void mass(const double& m) { _mass=m; }
  double x() const { return _x; }
  double y() const { return _y; }
  double dx() const { return _dx; }
  double dy() const { return _dy; }
  
  // Takes a force (in Newtons) as input and updates the state 
  void update(const double Fx, const double Fy, const double dt);
  double velocity() const;
  void print() const;
};
