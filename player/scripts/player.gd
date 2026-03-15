extends CharacterBody2D

@export var speed = 400
@export var bullet_scene: PackedScene
var screen_size
var health = 10

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction.length() > 0:
		position += direction * delta * speed
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

func take_damage():
	health -= 1
	if health <= 0:
		die()

func die():
	print("game over")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		print("alo")
		take_damage()
