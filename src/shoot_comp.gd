extends AudioStreamPlayer2D
class_name ShootComp

const BULLET: PackedScene = preload("res://src/bullet.tscn")

@onready var _beholder: Node = $/root/Main/BEHolder

func shoot(trans: Transform2D) -> void:
	var bullet: = BULLET.instantiate() as Bullet
	_beholder.add_child(bullet, true)
	bullet.spawn(trans.origin, Vector2.RIGHT.rotated(trans.get_rotation()))
	play()
