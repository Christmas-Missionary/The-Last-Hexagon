extends Node2D
class_name Main

static var time_played: float = 0.0
static var is_playing: bool = false

func _ready() -> void:
	print("Hello! You exist!")

func _physics_process(delta: float) -> void:
	if is_playing:
		time_played += delta

func _start_game() -> void:
	is_playing = true
	time_played = 0.0

func _end_game() -> void:
	is_playing = false
