extends Node2D
class_name Board

const BOARD_DIMENSIONS = Vector2(3, 3)

func _ready():
	build_board()

func build_board():
	for x in range(BOARD_DIMENSIONS.x):
		for y in range(BOARD_DIMENSIONS.y):
			print(x, y)
			var tile = load("res://Game/BoardTile.tscn").instance()
			tile.position = Vector2(x * 173, y * 176)
			tile.hide()
			add_child(tile)

