extends Area2D

const QUART: float = TAU / 4
const SPEED: float = 200.0

# borrowed from player constants
const _UPLEFT_BOUND: Vector2 = Vector2.ONE * 30.0
const _DOWNRIGHT_BOUND: Vector2 = Vector2(1200, 800) - _UPLEFT_BOUND

@onready var _player: = $/root/Main/Player as Node2D
@onready var gun: = $Gun as Node2D

func _spawn(pos: Vector2) -> void:
	position = pos

func _physics_process(delta: float) -> void:
	var direction: Vector2 = (_player.position - global_position).normalized()
	position += direction * SPEED * delta
	rotation = position.angle_to_point(_player.position)
	
	position = position.clamp(_UPLEFT_BOUND, _DOWNRIGHT_BOUND)

func _get_hit(area: Area2D) -> void:
	if area is Bullet:
		area.queue_free()
		queue_free()

func _hit_player(body: CharacterBody2D) -> void:
	if body is Player:
		(body as Player).energy -= 25

func _shoot() -> void:
	var bullet: = Player.BULLET.instantiate() as Bullet
	add_sibling(bullet, true)
	bullet.spawn(position, Vector2.RIGHT.rotated(rotation))
