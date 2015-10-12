module dentity.component;

template ComponentBase(T, int startingAmount = 8) {
  import std.conv : to;
  const char[] ComponentBase = "
  static this() {
    //components.reserve("~to!string(startingAmount)~");
  }
  public static:
    auto Add(arg...)(Entity entity, arg args) {
      return components[entity] = new "~T.stringof~"(args);
    }

    auto Get(Entity entity) {
      auto p = entity in components;
      return p ? *p : null;
    }

  private static:
    "~T.stringof~"*[Entity] components;
  ";
}
