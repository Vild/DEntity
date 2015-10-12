import std.stdio;

import dentity.component;
import dentity.entity;
import dentity.system;
import dentity.world;

struct vec3 {
	double x, y, z;
}

final class PositionComponent : Component {
public:
	this(vec3 pos) {
		this.pos = pos;
	}

	@property ref vec3 Position() { return pos; }

private:
	vec3 pos;
}

final class VelocityComponent : Component {
public:
	this(vec3 vel) {
		this.vel = vel;
	}

	@property ref vec3 Velocity() { return vel; }

private:
	vec3 vel;
}

final class MovementSystem : System {
public:
	this() {
	}

	override void Update(World world) {
		double delta = world.Delta;
		foreach (Entity entity; world.Entities) {
			auto pos = entity.GetComponent!PositionComponent;
			auto vel = entity.GetComponent!VelocityComponent;
			if (!pos || !vel)
				continue;

			pos.Position.x += vel.Velocity.x * delta;
			pos.Position.y += vel.Velocity.y * delta;
			pos.Position.z += vel.Velocity.z * delta;
			writeln(entity, " moved to ", pos.Position);
		}
	}
}


int main(string[] args) {
	World world = new World();
	Entity entity = world.NewEntity("Bob");
	entity.AddComponent!PositionComponent(vec3(0, 0, 2));
	entity.AddComponent!VelocityComponent(vec3(1, 2, -0.5));
	entity.Finalize();

	world.AddSystem!MovementSystem();

	import core.thread : Thread, msecs;

	while(true) {
		world.Delta = 1/5.0;
		world.Tick();
		Thread.sleep(200.msecs);
	}
}
