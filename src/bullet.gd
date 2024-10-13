extends Area2D
class_name Bullet

const SPEED: float = 600.0

var velocity: Vector2 = Vector2()

# Player calls this
func spawn(pos: Vector2, dir: Vector2) -> void:
	add_to_group(Main.BULLET_GROUP_NAME)
	body_entered.connect(_hit_body)
	velocity = dir * SPEED
	pos += (velocity / 20)
	position = pos

func _physics_process(delta: float) -> void:
	position += velocity * delta

# All 4 walls call this method
func bounce(wall_name: StringName) -> void:
	match (wall_name):
		&"UpWall": velocity.y = -velocity.y
		&"DownWall": velocity.y = -velocity.y
		&"RightWall": velocity.x = -velocity.x
		&"LeftWall": velocity.x = -velocity.x
		_: printerr("Object, " + wall_name + ", has wall.gd when it is not supposed to for bullet method, 'bounce'.")

func _hit_body(body: Node2D) -> void:
	if body is Player:
		(body as Player).energy -= 25
		queue_free()
