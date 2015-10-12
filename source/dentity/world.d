module dentity.world;

import dentity.entity;
import dentity.system;

final class World {
public:
  this() {
    delta = 0;
  }

  Entity NewEntity(arg...)(arg args) {
    auto e = new Entity(this, args);
    entities ~= e;
    return e;
  }

  T AddSystem(T : System, arg...)(arg args) {
    auto c = new T(args);
    systems[T.stringof] = c;
    return c;
  }

  void Tick() {
    foreach (System system; systems)
      system.Update(this);
  }

  @property ref double Delta() { return delta; }
  @property ref Entity[] Entities() { return entities; }
  @property ref System[string] Systems() { return systems; }
private:
  double delta;
  Entity[] entities;
  System[string] systems;
}
