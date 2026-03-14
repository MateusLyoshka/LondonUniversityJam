extends Node2D

@export var ENEMY_BASE_MOVE_SPEED = 10
@export var target: Node2D

var default_sprite: Texture2D = load("res://icon.svg")

class EnemyStats:
	var health: int
	var speed: float
	var texture: Texture2D
	
	func _init(h: int, s: float, t: Texture) -> void:
		health = h
		speed = s
		texture = t

var health_stats = {
	1: EnemyStats.new(1, 30, default_sprite),
	2: EnemyStats.new(2, 50, default_sprite)
}
var health = 2
var currentStat: EnemyStats = EnemyStats.new(1, 50, default_sprite)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_stat()

func _physics_process(delta: float) -> void:
	if target == null:		
		return
		
	var direction = (target.global_position - global_position).normalized()
	global_position += direction * ENEMY_BASE_MOVE_SPEED * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_stat() -> void:
	if health == 0:
		die()
	currentStat = health_stats[health]
	update_sprite()

func update_sprite() -> void:
	$Sprite2D.texture = currentStat.texture
	
func take_hit() -> void:
	health -= 1
	update_stat()
	
func die() -> void:
	queue_free()
