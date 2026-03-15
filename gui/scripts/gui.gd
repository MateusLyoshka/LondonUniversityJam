# GUI class
extends CanvasLayer

@onready var gui_props: GUIProperties = load("res://gui/resources/gui_properties.tres")

var current_gui: Control

func switch_gui(path_scene: String) -> void:
	if current_gui and current_gui.is_inside_tree():
		current_gui.queue_free()
	
	var gui_scene: PackedScene = gui_props.get_gui_scene_by_path(path_scene)
	var instance: Control = gui_scene.instantiate()
	current_gui = instance
	call_deferred("add_child", instance)

func start_game() -> void:
	get_tree().change_scene_to_file("res://maps/MasterRoom.tscn")
	switch_gui("res://gui/scenes/gameplay.tscn")
