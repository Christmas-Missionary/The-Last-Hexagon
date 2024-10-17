extends RichTextLabel
class_name TimePlayed

static var time_played: float = 0.0
static var is_playing: bool = false

func _physics_process(delta: float) -> void:
	if is_playing:
		time_played += delta
		var tenths_of_seconds: String = str(roundi(time_played * 10))
		text = tenths_of_seconds.insert(tenths_of_seconds.length() - 1, '.')

func _start_time() -> void:
	is_playing = true
	time_played = 0.0

func _stop_time() -> void:
	is_playing = false
