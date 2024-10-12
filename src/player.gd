extends CharacterBody2D
class_name Player

const _SPEED: float = 300.0

# ! WARNING DO NOT CHANGE THESE! WARNING !
# 30.0 is wall offset, (1200, 800) is length of arena.
const _UPLEFT_BOUND: Vector2 = Vector2.ONE * 30.0
const _DOWNRIGHT_BOUND: Vector2 = Vector2(1200, 800) - _UPLEFT_BOUND

var energy: float = 1200.0:
	set(val):
		energy = clampf(val, 0.0, 1200.0)
		energy_changed.emit(roundi(val))

var num_of_bullets: int = 80:
	set(val):
		num_of_bullets = val
		bullet_shot.emit(val)

signal energy_changed(new_val: int)
signal bullet_shot(new_val: int)

@onready var gun: = $PlayerGun as Sprite2D

func _physics_process(delta: float) -> void:
	# no cheating by going diagonal
	position += Input.get_vector(&"left", &"right", &"up", &"down") * _SPEED * delta
	
	# stays in arena
	position = position.clamp(_UPLEFT_BOUND, _DOWNRIGHT_BOUND)

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		energy -= 00.015625
	if event is InputEventKey:
		energy -= 0.125
	if event.is_action_pressed(&"shoot") and num_of_bullets > 0:
		energy -= 0.75
		num_of_bullets -= 1
		var bullet: = Preload.BULLET.instantiate() as Bullet
		add_sibling(bullet, true)
		bullet.spawn(position, Vector2.RIGHT.rotated(gun.rotation))
