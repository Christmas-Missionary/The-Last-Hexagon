extends Area2D
class_name Bullet

const _BULLET_UPLEFT: Vector2 = Vector2.ONE * 10.0
const _BULLET_DOWNRIGHT: Vector2 = Vector2(1190, 790)
const _SPEED: float = 600.0

var velocity: Vector2 = Vector2()

@onready var _bounce_sound: = $BounceSound as AudioStreamPlayer2D

## Player and square call this
func spawn(pos: Vector2, dir: Vector2) -> void:
	velocity = dir * _SPEED
	position = (pos + (velocity / 20)).clamp(Main.UPLEFT_BOUND, Main.DOWNRIGHT_BOUND)

func _physics_process(delta: float) -> void:
	position += velocity * delta
	
	# Check to see if bullet will bounce
	var last_vel: Vector2 = velocity
	if _BULLET_UPLEFT.y >= position.y or _BULLET_DOWNRIGHT.y <= position.y:
		velocity.y = -velocity.y
	if _BULLET_UPLEFT.x >= position.x or _BULLET_DOWNRIGHT.x <= position.x:
		velocity.x = -velocity.x
	if last_vel != velocity and TimePlayed.is_playing:
		_bounce_sound.play()

func _hit_body(body: Node2D) -> void:
	if body is Player:
		(body as Player).get_hit()
		queue_free()
