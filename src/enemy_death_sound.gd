extends AudioStreamPlayer2D
class_name EnemyDeathSound

func spawn(sound: AudioStream, pos: Vector2) -> void:
	stream = sound
	position = pos
	play()
