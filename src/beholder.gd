extends Node2D

signal enemy_spawned(pos: Vector2)

func _spawn_enemy() -> void:
	const TRIANGLE: PackedScene = preload("res://src/triangle.tscn")
	const SQUARE: PackedScene = preload("res://src/square.tscn")
	var pos: Vector2 = Vector2(
		randf_range(Main.UPLEFT_BOUND.x, Main.DOWNRIGHT_BOUND.x),
		randf_range(Main.UPLEFT_BOUND.y, Main.DOWNRIGHT_BOUND.y)
	)
	var enemy: Node = (
		TRIANGLE if Main.time_played < 15.0 || randf() > 0.5 else
		SQUARE).instantiate()
	add_child(enemy, true)
	enemy_spawned.connect(Callable(enemy, &"_spawn"), CONNECT_ONE_SHOT)
	enemy_spawned.emit(pos)

func _free_all_children() -> void:
	for child: Node in get_children():
		child.queue_free()
