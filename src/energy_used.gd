extends RichTextLabel

var _energy_used: float = 0

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		_energy_used += 0.015625
	if event is InputEventKey:
		_energy_used += 0.125
	if event.is_action_pressed(&"shoot"):
		_energy_used += 0.75
	
	text = "Energy used in menu: " + str(_energy_used).substr(0, 9)

func _turn_off() -> void:
	text = "Energy used in menu: 0"
	set_process_input(false)
	hide()
	_energy_used = 0

func _turn_on() -> void:
	set_process_input(true)
	show()
