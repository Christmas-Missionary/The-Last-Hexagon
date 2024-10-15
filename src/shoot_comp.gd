extends AudioStreamPlayer2D
class_name ShootComp

const BULLET: PackedScene = preload("res://src/bullet.tscn")

@onready var main: Node = $/root/Main

func shoot(trans: Transform2D) -> void:
	var bullet: = BULLET.instantiate() as Bullet
	main.add_child(bullet, true)
	bullet.spawn(trans.origin, Vector2.RIGHT.rotated(trans.get_rotation()))
	play()
