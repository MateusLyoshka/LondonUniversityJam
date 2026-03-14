extends Control

@onready var play_button: Button = $PlayButton

func _ready():
	play_button.pressed.connect(_on_play_pressed)

func _on_play_pressed() -> void:
	print("Play pressed")
	# TODO: Start the game (change scene, unpause, etc.)
