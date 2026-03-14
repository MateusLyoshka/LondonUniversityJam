class_name EnemyDataBase

class EnemyStat:
	var max_hp: int
	var speed: float = 2.0
	var name: String = "Unnamed"
	var texture: Texture2D = load("res://icon.svg")
	
	func _init(nm: String, m_hp: int, spd: float) -> void:
		self.max_hp = m_hp
		self.speed = spd
		self.name = nm

var ENEMIES := {
	"enemy_a": EnemyStat.new("a", 3, 2.0),
	"enemy_b": EnemyStat.new("b", 5, 0.5),
	"enemy_c": EnemyStat.new("b", 5, 50),
}
