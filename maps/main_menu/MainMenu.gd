extends Control

@onready var play_button: Button = $PlayButton

func _ready() -> void:
	GUI.switch_gui("res://gui/scenes/menu.tscn")
