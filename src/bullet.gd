extends Area2D
class_name Bullet

const SPEED: float = 600.0

var velocity: Vector2 = Vector2()

func _spawn(pos: Vector2, dir: Vector2):
	velocity = dir * SPEED
	pos += (velocity / 20)
	position = pos

func _physics_process(delta: float) -> void:
	position += velocity * delta

func bounce(wall_name: StringName) -> void:
	match (wall_name):
		&"UpWall": velocity.y = -velocity.y
		&"DownWall": velocity.y = -velocity.y
		&"RightWall": velocity.x = -velocity.x
		&"LeftWall": velocity.x = -velocity.x
		_: printerr("Object, " + wall_name + ", has wall.gd when it is not supposed to for bullet method, 'bounce'.")
