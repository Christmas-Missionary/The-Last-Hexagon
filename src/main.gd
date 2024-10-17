extends Node2D
class_name Main

# ! WARNING DO NOT CHANGE THESE! WARNING !
# 20.0 is wall offset, (1200, 800) is length of arena.
const UPLEFT_BOUND: Vector2 = Vector2.ONE * 20.0
const DOWNRIGHT_BOUND: Vector2 = Vector2(1200, 800) - UPLEFT_BOUND

func _ready() -> void:
	print("Hello! You exist!")
