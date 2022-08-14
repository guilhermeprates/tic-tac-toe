extends Node2D
class_name Board

const BOARD_DIMENSIONS = Vector2(3, 3)

var current_symbol: String

func _init():
	self.current_symbol = 'X'

func _ready():
	build_board()

func _physics_process(_delta):
	if Input.is_action_pressed("mouse_left_click"):
		print("mouse_left_click")

func build_board():
	for x in range(BOARD_DIMENSIONS.x):
		for y in range(BOARD_DIMENSIONS.y):
			var tile = load("res://Game/BoardTile.tscn").instance()
			add_child(tile)
			print(x, y)
			tile.set_position(Vector2(x * 173, y * 176))
