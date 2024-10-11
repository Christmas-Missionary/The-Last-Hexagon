extends Area2D

var velocity: Vector2 = Vector2()

func _physics_process(delta: float) -> void:
	position += velocity * delta
