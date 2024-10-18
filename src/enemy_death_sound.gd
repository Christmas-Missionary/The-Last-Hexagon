extends AudioStreamPlayer2D
class_name EnemyDeathSound

static var _template: = AudioStreamRandomizer.new()

static func _static_init() -> void:
	_template.random_pitch = 2.0

## Called by square and triangle
func spawn(sound: AudioStream, pos: Vector2) -> void:
	var to_insert: = _template
	to_insert.add_stream(0, sound)
	stream = to_insert
	position = pos
	play()
