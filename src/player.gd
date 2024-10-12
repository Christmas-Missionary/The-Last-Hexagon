extends CharacterBody2D

const _SPEED: float = 300.0
const _BULLET_SCENE: PackedScene = preload("res://src/bullet.tscn")

# ! WARNING DO NOT CHANGE THESE! WARNING !
# 30.0 is wall offset, (1200, 800) is length of arena.
const _UPLEFT_BOUND: Vector2 = Vector2.ONE * 30.0
const _DOWNRIGHT_BOUND: Vector2 = Vector2(1200, 800) - _UPLEFT_BOUND

@onready var gun: = $PlayerGun as Sprite2D

func _physics_process(delta: float) -> void:
	# unnormalized vector is fairer when EVERY key press is costly
	position.x += Input.get_axis(&"left", &"right") * _SPEED * delta
	position.y += Input.get_axis(&"up", &"down") * _SPEED * delta

	# stays in arena
	position = position.clamp(_UPLEFT_BOUND, _DOWNRIGHT_BOUND)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"shoot"):
		var bullet: = _BULLET_SCENE.instantiate() as Bullet
		add_sibling(bullet, true)
		bullet.spawn(position, Vector2.RIGHT.rotated(gun.rotation))
