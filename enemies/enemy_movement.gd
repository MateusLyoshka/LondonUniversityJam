extends CharacterBody2D

@export var ENEMY_BASE_MOVE_SPEED = 300

@onready var stats = get_parent().info
@onready var target = get_parent().target

func _physics_process(delta: float) -> void:
	if target == null:
		return
		
	var direction = (target.global_position - global_position).normalized()
	global_position += direction * ENEMY_BASE_MOVE_SPEED * delta * stats.speed
	
