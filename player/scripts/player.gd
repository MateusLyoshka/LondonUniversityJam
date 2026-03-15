extends Area2D

@export var speed = 400
@export var bullet_scene: PackedScene = load("res://effects/bullet_trail.tscn")
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var velocity = direction * speed
	if direction.length() > 0:
		position += velocity * delta
		# teleport signal
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)
	if Input.is_action_just_pressed("click"):
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = position
	bullet.direction = (get_global_mouse_position() - position).normalized()
	get_parent().add_child(bullet)
