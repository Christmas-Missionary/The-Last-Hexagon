extends Node2D
class_name Main

# borrowed from player constants
const _UPLEFT_BOUND: Vector2 = Vector2.ONE * 30.0
const _DOWNRIGHT_BOUND: Vector2 = Vector2(1200, 800) - _UPLEFT_BOUND

static var time_played: float = 0.0
static var is_playing: bool = true

signal enemy_spawned(pos: Vector2)

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
	add_sibling(enemy, true)
	enemy_spawned.connect(Callable(enemy, &"_spawn"), CONNECT_ONE_SHOT)
	enemy_spawned.emit(pos)
