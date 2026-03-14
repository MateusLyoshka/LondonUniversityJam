extends Node2D

@export var enemy_to_spawn: String = "enemy_a"
@export var enemy_scene: PackedScene = load("res://enemies/enemy.tscn")
@export var player: Node2D
@export var spawn_min_radius: float = 300
@export var spawn_max_radius: float = 1000
@export var enemies_count: int = 10
@export var spawn_interval: float = 2.0
@export var wait_interval: float = 3.0

var i = 0
@onready var enemy_stats = EnemyDataBase.new().ENEMIES[enemy_to_spawn]

func _ready():
	$Timer.wait_time = spawn_interval
	$Timer.timeout.connect(spawn_enemy)
	$Timer.start(wait_interval)

func spawn_enemy():
	i += 1
	if (i > enemies_count):
		print("Spawn finished!")
		queue_free()
		return
	
	print("Spawn enemy of type: " + enemy_to_spawn + ", " + str(i) + "/" + str(enemies_count))
	if enemy_to_spawn == null:
		return

	var enemy = enemy_scene.instantiate()
	enemy.target = player
	enemy.info = enemy_stats
	var angle = randf() * TAU
	var radius = randf_range(spawn_min_radius, spawn_max_radius)
	var offset = Vector2(
		cos(angle) * radius,
		sin(angle) * radius
	)
	enemy.global_position = player.global_position + offset
	get_tree().current_scene.add_child(enemy)
