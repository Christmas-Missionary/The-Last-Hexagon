extends Sprite2D

@onready var _player: = $/root/Main/Player as Node2D

func _physics_process(_delta) -> void:
	rotation = to_global(position).angle_to_point(_player.position)
