extends Area2D

@export_file("*.tscn") var next_room_path: String

@export var spawn_point_id: String # Used to identify the spawn point in the next room (e.g., "left", "right", "top", "bottom")

func _ready():
	self.body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		print("Player entered teleporter")
		var next_room_scene = load(next_room_path) as PackedScene
		if next_room_scene:
			# Later must be created a teleporter manager to handle the spawn points and player position in the next room
			var next_room = next_room_scene.instance()
			get_tree().change_scene_to(next_room_scene)