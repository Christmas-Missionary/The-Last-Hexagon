extends Enemy

@onready var _shoot_comp: = $ShootComp as ShootComp

func _notify_shoot_comp() -> void:
	_shoot_comp.shoot(position, position.angle_to_point(_shoot_comp.global_position))
