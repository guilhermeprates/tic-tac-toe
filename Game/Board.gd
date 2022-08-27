extends Node2D
class_name Board

const BOARD_DIMENSIONS = Vector2(3, 3)

enum PLAYER { X, O }

var board

func _ready():
	build_board()

func build_board():
	board = []
	for line in range(BOARD_DIMENSIONS.x):
		board.append([])
		for column in range(BOARD_DIMENSIONS.y):
			board[line].append(column)
	print(board)
