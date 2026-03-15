class_name GUIProperties extends Resource

@export var gui_scenes: Array[PackedScene]

func get_gui_scene_by_path(path: String) -> PackedScene:
	return gui_scenes.filter(func(scene): return scene.get_path() == path)[0]
