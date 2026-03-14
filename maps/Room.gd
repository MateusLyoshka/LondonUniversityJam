# Room.gd
extends Node2D

func _ready() -> void:
	# Use call_deferred to ensure the nodes are fully inside the tree
	# and sizes are calculated correctly before moving things.
	align_teleporters.call_deferred()
	var data = GameManager.get_current_room_data()
	setup_room(data)

func align_teleporters() -> void:
	var view_size = get_viewport_rect().size
	var w = view_size.x
	var h = view_size.y
	
	var half_w = w / 2
	var half_h = h / 2

	# Update SpawnPoints positions
	# Note: Ensure the parent "SpawnPoints" is at (0,0) or use global_position
	$SpawnPointsNorth.position = Vector2(half_w, 0)
	$SpawnPointsSouth.position = Vector2(half_w, view_size.y)
	$SpawnPointsEast.position = Vector2(view_size.x, half_h)
	$SpawnPointsWest.position = Vector2(0, half_h)
	$SpawnPointsCenter.position = Vector2(half_w, half_h)

	# Update Teleporters positions
	$TeleporterNorth.position = Vector2(half_w, 0)
	$TeleporterSouth.position = Vector2(half_w, view_size.y)
	$TeleporterEast.position = Vector2(view_size.x, half_h)
	$TeleporterWest.position = Vector2(0, half_h)

	# Rotation
	$TeleporterEast.rotation_degrees = 90
	$TeleporterWest.rotation_degrees = 90

func setup_room(data: RoomData) -> void:
	print("Setting up Room at ", GameManager.current_coords, " with difficulty ", data.difficulty)

	# Example: Change background color based on difficulty
	if data.difficulty > 2:
		$Background.modulate = Color(0.5, 0, 0) # Make it darker/redder for hard rooms

	# 4. Move player to the correct spawn point
	var spawn_node = get_node_or_null("SpawnPoints/" + GameManager.target_spawn_id)
	if spawn_node:
		$Player.global_position = spawn_node.global_position
