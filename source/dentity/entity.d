module dentity.entity;

import dentity.component;
import dentity.world;

final class Entity {
public:
  this(World world, string name) {
    this.world = world;
    this.name = name;
  }

  void Finalize() {
    alive = true;
  }
  @property ref bool Alive() { return alive; }

  override string toString() {
    import std.format;
    return format("Entity[\"%s\"]", name);
  }

private:
  World world;
  string name;
  bool alive;
}
