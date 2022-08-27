extends Node2D
class_name Board

const BOARD_DIMENSIONS = Vector2(3, 3)

var board
var tiles
var current_player
var players = [ Player.Symbol.X, Player.Symbol.O ]
var random_number_generator = RandomNumberGenerator.new()

func _ready():
	var random = random_number_generator.randf_range(0, players.size())
	current_player = players[random]
	set_observers()
	build_board()

func set_observers():
	tiles = []
	var childrens = get_children()
	for node in childrens:
		if node is BoardTile:
			node.connect("boardtile_clicked", self, "boardtile_clicked")
			tiles.append(node)
			print(node.get_board_position())

func reset_game():
	var childrens = get_children()
	for node in childrens:
		if node is BoardTile:
			node.set_symbol(Player.Symbol.None)

func build_board():
	board = []
	for line in range(BOARD_DIMENSIONS.x):
		board.append([])
		for column in range(BOARD_DIMENSIONS.y):
			board[line].append(column)
	print(board)	 

func update_current_player():
	if current_player == Player.Symbol.X:
		current_player = Player.Symbol.O
	else:
		current_player = Player.Symbol.X

func boardtile_clicked(line, column):
	print("%d,%d" % [line, column])
	for tile in tiles:
		if tile.line == line and tile.column == column:
			if tile.symbol == Player.Symbol.NONE:
				tile.set_symbol(current_player)
				update_current_player()
	check_winner()

func check_winner():
	pass
