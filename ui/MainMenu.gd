extends Control

@onready var play_button: Button = $PlayButton

func _ready() -> void:
	if not play_button:
		play_button = find_child("PlayButton", true, false) as Button
	if not play_button:
		printerr("MainMenu: PlayButton node not found")
		return
	play_button.pressed.connect(_on_play_pressed)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://maps/MasterRoom.tscn")
