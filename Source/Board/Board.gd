class_name Board extends Node2D

var board: Array = []
var tiles: Array = []
var game_over: bool = false
var minimax: Minimax
var player_one: Player
var player_two: Player
var current_player: Player
var winner: Player

func _ready() -> void:
	player_one = Player.new()
	player_one.set_symbol(Player.Symbol.X)
	player_two = Player.new()
	player_two.set_symbol(Player.Symbol.O)
	minimax = Minimax.new(player_two, player_one)
	current_player = player_one
	build_board()

func build_board() -> void:
	board = []
	var childrens = get_children()
	for node in childrens:
		if node is BoardTile:
			node.connect("boardtile_selected", self, "on_boardtile_selected")
			tiles.append(node)
			if range(board.size()).has(node.line):
				board[node.line].append(node.get_symbol())
			else:
				board.append([])
				board[node.line].append(node.get_symbol())
	print(board)
	
func reset_game() -> void:
	for line in range(3):
		for column in range(3):
			board[line][column] = Player.Symbol.None
	for tile in tiles:
		tile.set_symbol(Player.Symbol.None)
	current_player = player_one
	game_over = false

func update_current_player() -> void:
	if current_player == player_one:
		current_player = player_two
	else:
		current_player = player_one

func update_tile_symbol(line: int, column: int, symbol: int) -> void:
	for tile in tiles:
		if tile.line == line and tile.column == column:
			tile.set_symbol(symbol)

func on_boardtile_selected(line: int, column: int) -> void:
	print("%d,%d" % [line, column])
	
	if game_over: 
		reset_game()
		return
			
	var symbol = board[line][column]
	if symbol == Player.Symbol.None:
		board[line][column] = current_player.get_symbol()
		update_tile_symbol(line, column, current_player.get_symbol())
		check_winner()
		update_current_player()
	else:
		return
#
	if !game_over:
		var board_copy = board.duplicate()
		var move = minimax.get_move(board_copy)
		board[move.x][move.y] = current_player.get_symbol()
		update_tile_symbol(move.x, move.y, current_player.get_symbol())
		check_winner()
		update_current_player()

func check_winner():
	for line in range(3):
		if check_line(line):
			print("Winner Line")
			print(current_player)
			game_over = true
			return
	for column in range(3):
		if check_column(column):
			print("Winner Column")
			print(current_player)
			game_over = true
			return
	for diagonal in [0, 2]:
		if check_diagonal(diagonal):
			print("Winner Diagonal")
			print(current_player)
			game_over = true
			return
	if check_empty_tiles():
		print("A tie")
		game_over = true
		return

func check_line(line) -> bool:
	for column in range(3):
		if board[line][column] != current_player.get_symbol():
			return false
	return true
	
func check_column(column) -> bool:
	for line in range(3):
		if (board[line][column] != current_player.get_symbol()):
			return false
	return true

func check_diagonal(diagonal) -> bool:
	for line in range(3):
		var column
		if diagonal == 0:
			column = line
		else:
			column = 3 - line - 1
		if board[line][column] != current_player.get_symbol():
			return false
	return true

func check_empty_tiles() -> bool:
	var empty_tiles = 0
	for line in range(3):
		for column in range(3):
			if board[line][column] == Player.Symbol.None:
				empty_tiles += 1
	if empty_tiles == 0:
		return true
	else:
		return false
