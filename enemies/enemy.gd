extends Node2D

@export var target: Node2D
var info: EnemyDataBase.EnemyStat

var current_hp: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CharacterBody2D/Sprite2D.texture = info.texture	
	current_hp = info.max_hp
	
func take_hit() -> void:
	info.current_hp -= 1
	if current_hp <= 0:
		die()
	
func die() -> void:
	queue_free()
