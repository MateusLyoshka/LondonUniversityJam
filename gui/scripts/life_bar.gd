class_name LifeBar extends HBoxContainer

@export var player_props: PlayerProperties
@export var life_scene: PackedScene

var _max_hp_list: Array[Control] = []
var _current_hp: int

func _ready() -> void:
	BusEvent.player_take_damage.connect(set_current_hp)
	initialize(player_props.health)


func initialize(max_hp: int) -> void:
	_current_hp = max_hp
	for i in range(max_hp):
		var instance: Control = life_scene.instantiate()
		_max_hp_list.append(instance)
		add_child(instance)


func set_current_hp(value: int) -> void:
	if value <= 0:
		return
	if value > _max_hp_list.size():
		value = _max_hp_list.size()
	
	if value > _current_hp:
		var hp_value = _current_hp
		for i in range(hp_value, value):
			_max_hp_list[i].get_child(0).visible = true
			_current_hp += 1
	elif value < _current_hp:
		var hp_value = _current_hp
		for i in range(value, hp_value):
			_max_hp_list[i].get_child(0).visible = false
			_current_hp -= 1
