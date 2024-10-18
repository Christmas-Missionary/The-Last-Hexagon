## These constants have to go somewhere, might as well be here.
extends Node2D
class_name Main

## This is the upleft bound of a rect.
const UPLEFT_BOUND: Vector2 = Vector2.ONE * 20.0
## This is the downright (opposite) bound of a rect.
const DOWNRIGHT_BOUND: Vector2 = Vector2(1200, 800) - UPLEFT_BOUND

func _ready() -> void:
	print("Hello! You exist!")
