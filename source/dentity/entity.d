module dentity.entity;

import dentity.component;
import dentity.world;

final class Entity {
public:
  this(World world, string name) {
    this.world = world;
    this.name = name;
  }
  ~this() {
    components.destroy;
  }

  void Finalize() {
    alive = true;
  }

  T AddComponent(T : Component, arg...)(arg args) {
    auto c = new T(args);
    components[T.stringof] = c;
    return c;
  }

  T * GetComponent(T: Component)() {
    return cast(T *)(T.stringof in components);
  }

  @property ref bool Alive() { return alive; }
  @property ref Component[string] Components() { return components; }

  override string toString() {
    import std.format;
    return format("Entity[\"%s\"]", name);
  }

private:
  World world;
  string name;
  bool alive;
  Component[string] components;
}
