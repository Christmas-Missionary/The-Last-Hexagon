extends Area2D

const SPEED: float = 600.0

var velocity: Vector2 = Vector2()

func spawn(pos: Vector2, dir: Vector2):
	velocity = dir * SPEED
	pos += (velocity / 20)
	position = pos

func _physics_process(delta: float) -> void:
	position += velocity * delta
