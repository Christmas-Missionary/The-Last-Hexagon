extends Sprite2D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		rotation = to_global(position).angle_to_point(get_global_mouse_position())
