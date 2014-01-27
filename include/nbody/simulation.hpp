
// Wrap everything in a namespace
namespace nbody {
  class Simulation {
    // whatever private stuff is needed
    // Rule of three
    public:
      void loadRun( std::istream );
      void saveRun( std::ostream ) const;
      void evolveSystemFor( double timeInSeconds );
  };

} // namespace nbody
// no semicolon at end
// name space can be spread across multiple files
// use:  nbody::Simulation

