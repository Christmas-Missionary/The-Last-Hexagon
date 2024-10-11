extends CharacterBody2D

const _SPEED: float = 300.0

func _physics_process(delta: float) -> void:
	
	# unnormalized vector is fairer when every key press costs
	position.x += Input.get_axis(&"left", &"right") * _SPEED * delta
	position.y += Input.get_axis(&"up", &"down") * _SPEED * delta
