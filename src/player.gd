extends CharacterBody2D

const _SPEED: float = 300.0

# ! WARNING DO NOT CHANGE THESE! WARNING !
# 30.0 is wall offset, (1200, 800) is length of arena.
const _UPLEFT_BOUND: Vector2 = Vector2.ONE * 30.0
const _DOWNRIGHT_BOUND: Vector2 = Vector2(1200, 800) - _UPLEFT_BOUND


func _physics_process(delta: float) -> void:
	# unnormalized vector is fairer when EVERY key press is costly
	position.x += Input.get_axis(&"left", &"right") * _SPEED * delta
	position.y += Input.get_axis(&"up", &"down") * _SPEED * delta

	# stays in arena
	position = position.clamp(_UPLEFT_BOUND, _DOWNRIGHT_BOUND)
	
