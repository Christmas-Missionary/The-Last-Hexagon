extends CharacterBody2D
class_name Player

const _SPEED: float = 300.0
const _STARTING_ENERGY: float = 1200.0
const _STARTING_BULLETS: int = 240

const MOUSE_COST: float = 1 / 64.0
const KEY_COST: float = 1 / 8.0
const SHOOT_COST: float = 3 / 4.0

var _energy: float = _STARTING_ENERGY:
	set(val):
		_energy = val
		energy_changed.emit(roundi(val))
		if _energy <= 0.0:
			no_energy_left.emit()
			_stop()

var _num_of_bullets: int = _STARTING_BULLETS:
	set(val):
		_num_of_bullets = val
		bullet_shot.emit(val)

signal energy_changed(new_val: int)
signal no_energy_left
signal bullet_shot(new_val: int)

@onready var _coll: = $Collision as CollisionPolygon2D
@onready var _hit_sound: = $HitSound as AudioStreamPlayer2D
@onready var _shoot_comp: = $ShootComp as ShootComp
@onready var _tree: SceneTree = get_tree()

func _ready() -> void:
	_stop()

func _physics_process(delta: float) -> void:
	# no cheating by going diagonal
	position = (
		position + Input.get_vector(&"left", &"right", &"up", &"down") * _SPEED * delta
	).clamp(Main.UPLEFT_BOUND, Main.DOWNRIGHT_BOUND) # stays in arena

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		_energy -= MOUSE_COST
		rotation = position.angle_to_point(get_global_mouse_position())
	if event is InputEventKey:
		_energy -= KEY_COST
	if event.is_action_pressed(&"shoot") and _num_of_bullets > 0:
		_energy -= SHOOT_COST
		_num_of_bullets -= 1
		_shoot_comp.shoot(position, rotation)

func _start() -> void:
	position = Vector2(600, 700)
	_energy = _STARTING_ENERGY
	_num_of_bullets = _STARTING_BULLETS
	set_physics_process(true)
	set_process_input(true)
	show()
	await _tree.process_frame
	_coll.set_disabled(false)

func _stop() -> void:
	set_physics_process(false)
	set_process_input(false)
	hide()
	await _tree.process_frame
	_coll.set_disabled(true)

# Called by bullet, triangle, and square
func get_hit() -> void:
	_energy -= 25
	_hit_sound.play()
