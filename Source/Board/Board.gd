extends Node2D
class_name Board

var board = []
var game_over = false
var current_player = Player.Symbol.None

func _ready():
	var players = [ Player.Symbol.X, Player.Symbol.O ]
	var random_number_generator = RandomNumberGenerator.new()
	var random = random_number_generator.randf_range(0, players.size())
	current_player = players[random]
	build_board()

func build_board():
	board = []
	var childrens = get_children()
	for node in childrens:
		if node is BoardTile:
			node.connect("boardtile_clicked", self, "boardtile_clicked")
			if range(board.size()).has(node.line):
				board[node.line].append(node)
			else:
				board.append([])
				board[node.line].append(node)
			print(node.get_board_position())

func reset_game():
	var childrens = get_children()
	for node in childrens:
		if node is BoardTile:
			node.set_symbol(Player.Symbol.None)
	game_over = false

func update_current_player():
	if current_player == Player.Symbol.X:
		current_player = Player.Symbol.O
	else:
		current_player = Player.Symbol.X

func boardtile_clicked(line, column):
	if game_over:
		reset_game()
	print("%d,%d" % [line, column])
	var tile = board[line][column]
	if tile.symbol == Player.Symbol.None:
		tile.set_symbol(current_player)
		check_winner()
		update_current_player()

func check_winner():
	for line in range(3):
		if check_line(line):
			print("Winner")
			print(current_player)
			game_over = true
	for column in range(3):
		if check_column(column):
			print("Winner")
			print(current_player)
			game_over = true
	for diagonal in [0, 2]:
		if check_diagonal(diagonal):
			print("Winner")
			print(current_player)
			game_over = true
	
func check_line(line) -> bool:
	for column in range(3):
		if board[line][column].symbol != current_player:
			return false
	return true
	
func check_column(column) -> bool:
	for line in range(3):
		if (board[line][column].symbol != current_player):
			return false
	return true

func check_diagonal(diagonal) -> bool:
	for line in range(3):
		var column
		if diagonal == 0:
			column = line
		else:
			column = 3 - line - 1
		if board[line][column].symbol != current_player:
			return false
	return true
