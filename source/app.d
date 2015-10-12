import std.stdio;

import dentity.component;
import dentity.entity;
import dentity.system;
import dentity.world;

struct vec3 {
	double x, y, z;
}

final struct PositionComponent {
	vec3 Position;
	alias Position this;
	mixin(ComponentBase!PositionComponent);
}

final struct VelocityComponent {
	vec3 Velocity;
	alias Velocity this;
	mixin(ComponentBase!VelocityComponent);
}

final class MovementSystem : System {
public:
	this() {
	}

	override void Update(World world) {
		double delta = world.Delta;

		foreach (Entity entity; world.Entities) {
			auto pos = PositionComponent.Get(entity);
			auto vel = VelocityComponent.Get(entity);
			if (!pos || !vel)
				continue;

			pos.x += vel.x * delta;
			pos.y += vel.y * delta;
			pos.z += vel.z * delta;
			writeln(entity, " moved to ", pos.Position);
		}
	}
}


int main(string[] args) {
	World world = new World();
	Entity entity = world.NewEntity("Bob");
	PositionComponent.Add(entity, vec3(0, 0, 2));
	VelocityComponent.Add(entity, vec3(1, 2, -0.5));
	entity.Finalize();

	world.AddSystem!MovementSystem();

	import core.thread : Thread, msecs;

	while(true) {
		world.Delta = 1/5.0;
		world.Tick();
		Thread.sleep(200.msecs);
	}
}
