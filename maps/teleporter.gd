extends Area2D

@export var next_room: RoomData
@export var spawn_id: String = "" # Used to identify the spawn point in the next room (e.g., "left", "right", "top", "bottom")
@export var direction: Vector2i

func _ready() -> void:
	pass

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("player"):
		return

	print("colliding")
	var new_coords = GameManager.current_coords + direction
	GameManager.change_room(new_coords, spawn_id)
