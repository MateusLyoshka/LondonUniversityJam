class_name MapData

var difficulty_grid: Array = [
	[1, 1, 2],
	[1, 2, 3],
	[2, 3, 4]
]

var difficulty_parameters: Dictionary = {
	1: {
		"enemy_to_spawn": "enemy_a",
		"enemies_count": 5,
		"spawn_interval": 3.0
	},
	2: {
		"enemy_to_spawn": "enemy_b",
		"enemies_count": 10,
		"spawn_interval": 2.0
	},
	3: {
		"enemy_to_spawn": "enemy_c",
		"enemies_count": 15,
		"spawn_interval": 1.5
	},
	4: {
		"enemy_to_spawn": "enemy_d",
		"enemies_count": 20,
		"spawn_interval": 1.0
	}
}
