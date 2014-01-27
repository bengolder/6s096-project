  // velocity
  // acceleration
  // masses
  // output format
  // output as text file

namespace nbody {
  class Body {
    vector _velocity;
    vector _acceleration;
    vector _mass;
    Body // constructor
    ~Body // free
    public:
      const void velocity() {};
      const void acceleration() {};
      const void mass() {};
      void &velocity( vector velocity ) {};
      void &acceleration( vector acceleration ) {};
      void &mass( vector mass ) {};
      const void printBody() {};
  };
}


template <typename T>
class Vector3 {
  T, _x, _y, _z;
};

// we are treating these objects as immutable,
// This speeds up the calculation
template <typename T>
inline const Vector3<T> operator+( const Vector3<T> &a,
                                   const Vector3<T> &a  ) {
  return Vector3<T> { a.x() + b.x(), a.y() + b.y(), a.z() + b.z() };
}
