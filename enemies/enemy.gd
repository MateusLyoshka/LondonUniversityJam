extends Node2D

@export var target: Node2D
var death_explosion: PackedScene = load("res://enemies/explosion.tscn")
var info: EnemyDataBase.EnemyStat

var current_hp: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#info = EnemyDataBase.EnemyStat.new("enemie1", 10, 10)
	modulate = info.color
	$CharacterBody2D/Sprite2D.texture = info.texture
	current_hp = info.max_hp
	
func take_hit() -> void:
	current_hp -= 1
	if current_hp <= 0:
		die()
	
func die() -> void:
	var explosion = death_explosion.instantiate()
	explosion.global_position = $CharacterBody2D.global_position
	explosion.modulate = modulate
	get_tree().current_scene.add_child(explosion)
	queue_free()
