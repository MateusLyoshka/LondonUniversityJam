extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 2.0
@export var player: Node2D
@export var spawn_min_radius: float = 300
@export var spawn_max_radius: float = 1000

func _ready():
	spawn_enemy()
	start_spawning()

func start_spawning():
	$Timer.wait_time = spawn_interval

	$Timer.timeout.connect(spawn_enemy)

func spawn_enemy():
	if enemy_scene == null:
		return

	var enemy = enemy_scene.instantiate()
	enemy.target = player
	var angle = randf() * TAU
	var radius = randf_range(spawn_min_radius, spawn_max_radius)
	var offset = Vector2(
		cos(angle) * radius,
		sin(angle) * radius
	)
	enemy.global_position = player.global_position + offset
	get_tree().current_scene.add_child(enemy)
