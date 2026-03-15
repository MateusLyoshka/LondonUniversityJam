extends CPUParticles2D

func _ready() -> void:
	emitting = true
	await get_tree().create_timer(lifetime).timeout
	get_parent().queue_free()
