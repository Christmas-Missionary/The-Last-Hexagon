extends Area2D

const SQUARE_DIES_SOUND: AudioStreamWAV = preload("res://audio/square_dies.wav")

const QUART: float = TAU / 4
const SPEED: float = 200.0

@onready var _player: = $/root/Main/Player as Node2D
@onready var _shoot_comp: = $ShootComp as ShootComp

func _physics_process(delta: float) -> void:
	var direction: Vector2 = _player.position - global_position
	var angle: float = transform.x.angle_to(direction) - QUART
	rotate(signf(angle) * minf(delta * 3.0, absf(angle))) 
	position += Vector2.RIGHT.rotated(rotation + QUART) * SPEED * delta
	
	position = position.clamp(Main.UPLEFT_BOUND, Main.DOWNRIGHT_BOUND)

func _get_hit(area: Area2D) -> void:
	if area is Bullet:
		const ENEMY_DEATH_SOUND: PackedScene = preload("res://src/enemy_death_sound.tscn")
		var death_sound: = ENEMY_DEATH_SOUND.instantiate() as EnemyDeathSound
		add_sibling(death_sound, true)
		death_sound.spawn(SQUARE_DIES_SOUND, position)
		area.queue_free()
		queue_free()

func _hit_player(body: CharacterBody2D) -> void:
	if body is Player:
		(body as Player).get_hit()


func _notify_shoot_comp() -> void:
	_shoot_comp.shoot(position, position.angle_to_point(_shoot_comp.global_position))
