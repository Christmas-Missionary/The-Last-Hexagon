extends Node2D
class_name Main

# borrowed from player constants
const _UPLEFT_BOUND: Vector2 = Vector2.ONE * 30.0
const _DOWNRIGHT_BOUND: Vector2 = Vector2(1200, 800) - _UPLEFT_BOUND

const BULLET_GROUP_NAME: StringName = &"Bullets"
const ENEMY_GROUP_NAME: StringName = &"Enemies"

static var time_played: float = 0.0
static var is_playing: bool = false

signal enemy_spawned(pos: Vector2)

func _ready() -> void:
	print("Hello! You exist!")

func _physics_process(delta: float) -> void:
	if is_playing:
		time_played += delta

func _spawn_enemy() -> void:
	var pos: Vector2 = Vector2(
		randf_range(_UPLEFT_BOUND.x, _DOWNRIGHT_BOUND.x),
		randf_range(_UPLEFT_BOUND.y, _DOWNRIGHT_BOUND.y)
	)
	var enemy: Node = (
		Preload.TRIANGLE if time_played < 15.0 || randf() > 0.5 else
		Preload.SQUARE).instantiate()
	add_child(enemy, true)
	move_child(enemy, 5)
	enemy.add_to_group(ENEMY_GROUP_NAME)
	enemy_spawned.connect(Callable(enemy, &"_spawn"), CONNECT_ONE_SHOT)
	enemy_spawned.emit(pos)

func _start_game() -> void:
	get_tree().call_group(BULLET_GROUP_NAME, &"queue_free")
	get_tree().call_group(ENEMY_GROUP_NAME, &"queue_free")
	is_playing = true
	time_played = 0.0

func _end_game() -> void:
	is_playing = false
