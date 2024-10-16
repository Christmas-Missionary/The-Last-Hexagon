extends Area2D
class_name Bullet

const SPEED: float = 600.0

var velocity: Vector2 = Vector2()

@onready var _bounce_sound: = $BounceSound as AudioStreamPlayer2D

# Player calls this
func spawn(pos: Vector2, dir: Vector2) -> void:
	body_entered.connect(_hit_body)
	velocity = dir * SPEED
	pos += (velocity / 20)
	position = pos

func _physics_process(delta: float) -> void:
	position += velocity * delta
	
	# Check to see if bullet will bounce
	var last_vel: Vector2 = velocity
	if Main.UPLEFT_BOUND.y >= position.y or Main.DOWNRIGHT_BOUND.y <= position.y:
		velocity.y = -velocity.y
	if Main.UPLEFT_BOUND.x >= position.x or Main.DOWNRIGHT_BOUND.x <= position.x:
		velocity.x = -velocity.x
	if last_vel != velocity and Main.is_playing:
		_bounce_sound.play()

func _hit_body(body: Node2D) -> void:
	if body is Player:
		(body as Player).get_hit()
		queue_free()
