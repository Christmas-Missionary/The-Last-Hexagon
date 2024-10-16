## @experimental: The moment an "Enemy" doesn't use all features of this class, the thing it doesn't want must be abstracted as a seperate component.
extends Area2D
class_name Enemy

const QUART: float = TAU / 4
const SPEED: float = 200.0

@export var death_sound: AudioStream

@onready var _player: = $/root/Main/Player as Node2D

func _init() -> void:
	area_entered.connect(_get_hit)
	body_entered.connect(_hit_player)

func _physics_process(delta: float) -> void:
	var direction: Vector2 = _player.position - global_position
	var angle: float = transform.x.angle_to(direction) - QUART
	rotate(signf(angle) * minf(delta * 3.0, absf(angle))) 
	position += Vector2.RIGHT.rotated(rotation + QUART) * SPEED * delta
	
	position = position.clamp(Main.UPLEFT_BOUND, Main.DOWNRIGHT_BOUND)

func _get_hit(area: Area2D) -> void:
	if area is Bullet:
		const ENEMY_DEATH_SOUND: PackedScene = preload("res://src/enemy_death_sound.tscn")
		var death_sound_scene: = ENEMY_DEATH_SOUND.instantiate() as EnemyDeathSound
		add_sibling(death_sound_scene, true)
		death_sound_scene.spawn(death_sound, position)
		area.queue_free()
		queue_free()

func _hit_player(body: CharacterBody2D) -> void:
	if body is Player:
		(body as Player).get_hit()
