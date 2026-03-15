extends Resource

class_name RoomData

@export_group("Data")
@export var room_scene_path: String
@export var difficulty: int = 1
@export var spawn_point_id: String # Used to identify the spawn point in the room (e.g., "left", "right", "top", "bottom")

@export_group("Exits")
@export var north_exit: RoomData
@export var south_exit: RoomData
@export var east_exit: RoomData
@export var west_exit: RoomData
