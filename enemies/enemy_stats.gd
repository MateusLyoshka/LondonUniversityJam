class_name EnemyDataBase

class EnemyStat:
	var max_hp: int
	var speed: float = 0.5
	var name: String = "Unnamed"
	var texture: Texture2D = load("res://player/sprite/player.png")
	var color: Color = Color.RED
	
	func _init(nm: String, m_hp: int, spd: float, col: Color = Color.RED) -> void:
		self.max_hp = m_hp
		self.speed = spd
		self.name = nm
		self.color = col

var ENEMIES := {
	"enemy_a": EnemyStat.new("a", 3, 1, Color.RED),
	"enemy_b": EnemyStat.new("b", 5, 1.2, Color.AQUA),
	"enemy_c": EnemyStat.new("c", 5, 1.3, Color.YELLOW_GREEN),
	"enemy_d": EnemyStat.new("d", 7, 1.4, Color.CORNFLOWER_BLUE)
}
