extends CharacterBody2D
class_name Player

const _SPEED: float = 300.0

# ! WARNING DO NOT CHANGE THESE! WARNING !
# 30.0 is wall offset, (1200, 800) is length of arena.
const _UPLEFT_BOUND: Vector2 = Vector2.ONE * 30.0
const _DOWNRIGHT_BOUND: Vector2 = Vector2(1200, 800) - _UPLEFT_BOUND

const _STARTING_ENERGY: float = 1200.0
const _STARTING_BULLETS: int = 240

var energy: float = _STARTING_ENERGY:
	set(val):
		energy = val
		energy_changed.emit(roundi(val))
		if energy <= 0.0:
			no_energy_left.emit()

var num_of_bullets: int = _STARTING_BULLETS:
	set(val):
		num_of_bullets = val
		bullet_shot.emit(val)

signal energy_changed(new_val: int)
signal no_energy_left
signal bullet_shot(new_val: int)

@onready var _coll: = $CollisionPolygon2D as CollisionPolygon2D
@onready var _hit_sound: = $HitSound as AudioStreamPlayer2D
@onready var _shoot_sound: = $ShootSound as AudioStreamPlayer2D

func _ready() -> void:
	_stop()

func _physics_process(delta: float) -> void:
	# no cheating by going diagonal
	position += Input.get_vector(&"left", &"right", &"up", &"down") * _SPEED * delta
	
	# stays in arena
	position = position.clamp(_UPLEFT_BOUND, _DOWNRIGHT_BOUND)

## This does not load in Preload, keep it here for now.
const BULLET: PackedScene = preload("res://src/bullet.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		energy -= 0.015625
		rotation = position.angle_to_point(get_global_mouse_position())
	if event is InputEventKey:
		energy -= 0.125
	if event.is_action_pressed(&"shoot") and num_of_bullets > 0:
		energy -= 0.75
		num_of_bullets -= 1
		var bullet: = BULLET.instantiate() as Bullet
		add_sibling(bullet, true)
		bullet.spawn(position, Vector2.RIGHT.rotated(rotation))
		_shoot_sound.play()

func _start() -> void:
	_coll.set_deferred(&"disabled", false)
	position = Vector2(600, 700)
	energy = _STARTING_ENERGY
	num_of_bullets = _STARTING_BULLETS
	set_physics_process(true)
	set_process_input(true)
	show()

func _stop() -> void:
	_coll.set_deferred(&"disabled", true)
	set_physics_process(false)
	set_process_input(false)
	hide()

# Called by bullet, triangle, and square
func get_hit() -> void:
	energy -= 25
	_hit_sound.play()
