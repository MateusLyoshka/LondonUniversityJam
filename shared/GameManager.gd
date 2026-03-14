extends Node

@export var map_data_path: String = "res://maps/MapData.tres"

var rooms: Array = []
var current_coords: Vector2i = Vector2i(0, 0)
var target_spawn_id: String = "center"

func _ready() -> void:
	_generate_rooms()

func _generate_rooms() -> void:
	var map_data = MapData.new()
	var grid = map_data.difficulty_grid

	rooms.clear()
	for y in range(grid.size()):
		var row_data = grid[y]
		var row_rooms: Array = []
		for x in range(row_data.size()):
			var room = RoomData.new()
			room.difficulty = int(row_data[x])
			row_rooms.append(room)
		rooms.append(row_rooms)

	# Wire exits
	for y in range(rooms.size()):
		for x in range(rooms[y].size()):
			var room = rooms[y][x]
			
			# Sintaxe: valor_se_verdade if condicao else valor_se_falso
			room.north_exit = rooms[y - 1][x] if y > 0 else null
			room.south_exit = rooms[y + 1][x] if y < rooms.size() - 1 else null
			room.west_exit = rooms[y][x - 1] if x > 0 else null
			room.east_exit = rooms[y][x + 1] if x < rooms[y].size() - 1 else null
	# Print results
	print("---- Generated Rooms ----")
	for y in range(rooms.size()):
		for x in range(rooms[y].size()):
			var r = rooms[y][x]
			print("Room (%d,%d) difficulty=%d north=%s south=%s west=%s east=%s" % [x, y, r.difficulty, r.north_exit != null, r.south_exit != null, r.west_exit != null, r.east_exit != null])

func load_initial_room() -> void:
	# Call this to start the game at 0,0
	change_room(Vector2i(0, 0), "center")
	
func change_room(new_coords: Vector2i, spawn_id: String) -> void:
	current_coords = new_coords
	target_spawn_id = spawn_id
	# Reload the MasterRoom scene
	# This will trigger MasterRoom._ready(), which will then ask for the data
	get_tree().change_scene_to_file("res://scenes/MasterRoom.tscn")
	
func get_current_room_data() -> RoomData:
	return rooms[current_coords.y][current_coords.x]
