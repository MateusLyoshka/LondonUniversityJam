# Room.gd
extends Node2D
const PLAYER_SCENE = preload("res://player/scenes/player.tscn")

func _ready() -> void:
	# Use call_deferred to ensure the nodes are fully inside the tree
	# and sizes are calculated correctly before moving things.
	align_teleporters()
	var data = GameManager.get_current_room_data()
	setup_room(data)
	spawn_player()

func align_teleporters() -> void:
	var view_size = get_viewport_rect().size
	var w = view_size.x
	var h = view_size.y
	
	var offset = 60
	
	var half_w = w / 2
	var half_h = h / 2

	# Update SpawnPoints positions
	# Note: Ensure the parent "SpawnPoints" is at (0,0) or use global_position
	$SpawnPointsNorth.position = Vector2(half_w, offset)
	$SpawnPointsSouth.position = Vector2(half_w, view_size.y - offset)
	$SpawnPointsEast.position = Vector2(view_size.x - offset, half_h)
	$SpawnPointsWest.position = Vector2(offset, half_h)
	$SpawnPointsCenter.position = Vector2(half_w, half_h)

	# Update Teleporters positions
	$TeleporterNorth.position = Vector2(half_w, 0)
	$TeleporterSouth.position = Vector2(half_w, view_size.y)
	$TeleporterEast.position = Vector2(view_size.x, half_h)
	$TeleporterWest.position = Vector2(0, half_h)

	# Rotation
	$TeleporterNorth.rotation_degrees = 90
	$TeleporterSouth.rotation_degrees = 90

func setup_room(data: RoomData) -> void:
	print("Setting up Room at ", GameManager.current_coords, " with difficulty ", data.difficulty)
	# 1. Visual changes
	if data.difficulty > 2:
		$Background.modulate = Color(0.5, 0, 0)
	# 2. Configure Teleporters (The "Handshake")
	# We set: direction (Vector2i) and the name of the marker in the NEXT room

	# NORTH
	if data.north_exit != null:
		$TeleporterNorth.direction = Vector2i(0, -1)
		$TeleporterNorth.spawn_id = "South" # Enter North, arrive at South
		$TeleporterNorth.visible = true
	else:
		$TeleporterNorth.visible = false
		$TeleporterNorth.set_deferred("monitoring", false)

	# SOUTH
	if data.south_exit != null:
		$TeleporterSouth.direction = Vector2i(0, 1)
		$TeleporterSouth.spawn_id = "North" # Enter South, arrive at North
		$TeleporterSouth.visible = true
	else:
		$TeleporterSouth.visible = false
		$TeleporterSouth.set_deferred("monitoring", false)

	# EAST
	if data.east_exit != null:
		$TeleporterEast.direction = Vector2i(1, 0)
		$TeleporterEast.spawn_id = "West"   # Enter East, arrive at West
		$TeleporterEast.visible = true
	else:
		$TeleporterEast.visible = false
		$TeleporterEast.set_deferred("monitoring", false)

	# WEST
	if data.west_exit != null:
		$TeleporterWest.direction = Vector2i(-1, 0)
		$TeleporterWest.spawn_id = "East"   # Enter West, arrive at East
		$TeleporterWest.visible = true
	else:
		$TeleporterWest.visible = false
		$TeleporterWest.set_deferred("monitoring", false)

		
func spawn_player() -> void:
	var player_instance = PLAYER_SCENE.instantiate()
	add_child(player_instance)

	# Position player at the Marker2D matching GameManager.target_spawn_id
	var spawn_node = get_node_or_null("SpawnPoints" + GameManager.target_spawn_id)
	if spawn_node:
		player_instance.global_position = spawn_node.global_position
	else:
		# Emergency fallback to center
		player_instance.global_position = $SpawnPointsCenter.global_position
		
	$EnemySpawner.player = player_instance
