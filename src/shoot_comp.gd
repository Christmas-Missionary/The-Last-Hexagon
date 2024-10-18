extends AudioStreamPlayer2D
class_name ShootComp

const _BULLET: PackedScene = preload("res://src/bullet.tscn")

@onready var _beholder: Node = $/root/Main/BEHolder

## Called by Player and Square
func shoot(pos: Vector2, rot: float) -> void:
	var bullet: = _BULLET.instantiate() as Bullet
	_beholder.add_child(bullet, true)
	bullet.spawn(pos, Vector2.RIGHT.rotated(rot))
	play()
