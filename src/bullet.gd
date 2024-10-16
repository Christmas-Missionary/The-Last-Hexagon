extends Area2D
class_name Bullet

const BULLET_UPLEFT: Vector2 = Vector2.ONE * 10.0
const BULLET_DOWNRIGHT: Vector2 = Vector2(1190, 790)
const SPEED: float = 600.0

var velocity: Vector2 = Vector2()

@onready var _bounce_sound: = $BounceSound as AudioStreamPlayer2D

# Player calls this
func spawn(pos: Vector2, dir: Vector2) -> void:
	body_entered.connect(_hit_body)
	velocity = dir * SPEED
	pos += (velocity / 20)
	position = pos.clamp(Main.UPLEFT_BOUND, Main.DOWNRIGHT_BOUND)

func _physics_process(delta: float) -> void:
	position += velocity * delta
	
	# Check to see if bullet will bounce
	var last_vel: Vector2 = velocity
	if BULLET_UPLEFT.y >= position.y or BULLET_DOWNRIGHT.y <= position.y:
		velocity.y = -velocity.y
	if BULLET_UPLEFT.x >= position.x or BULLET_DOWNRIGHT.x <= position.x:
		velocity.x = -velocity.x
	if last_vel != velocity and Main.is_playing:
		_bounce_sound.play()

func _hit_body(body: Node2D) -> void:
	if body is Player:
		(body as Player).get_hit()
		queue_free()
