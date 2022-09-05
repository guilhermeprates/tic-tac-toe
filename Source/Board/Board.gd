class_name Board extends Node2D

var board: Array = []
var game_over: bool = false
var player_one: Player
var player_two: Player
var current_player: Player
var winner: Player
var minimax: Minimax

func _ready() -> void:
	minimax = Minimax.new()
	player_one = Player.new()
	player_one.set_symbol(Player.Symbol.X)
	player_two = Player.new()
	player_two.set_symbol(Player.Symbol.O)
	current_player = player_one
	build_board()

func build_board() -> void:
	board = []
	var childrens = get_children()
	for node in childrens:
		if node is BoardTile:
			node.connect("boardtile_clicked", self, "on_boardtile_clicked")
			if range(board.size()).has(node.line):
				board[node.line].append(node)
			else:
				board.append([])
				board[node.line].append(node)

func reset_game() -> void:
	var childrens = get_children()
	for node in childrens:
		if node is BoardTile:
			node.set_symbol(Player.Symbol.None)
	game_over = false

func update_current_player() -> void:
	if current_player == player_one:
		current_player = player_two
	else:
		current_player = player_one

func on_boardtile_clicked(line, column) -> void:
	print("%d,%d" % [line, column])
	
	if game_over:
		reset_game()
		return
	
	var tile = board[line][column]
	if tile.symbol == Player.Symbol.None:
		tile.set_symbol(Player.Symbol.X)
		check_winner()
#		if !check_winner(board.duplicate(), current_player):
		update_current_player()
	else:
		return
	
	if !game_over:
		var tile_ai = Dummy.new().get_move(board)
		tile_ai.set_symbol(current_player.get_symbol())
#		if !check_winner(board.duplicate(), current_player):
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
		if board[line][column].symbol != current_player.get_symbol():
			return false
	return true
	
func check_column(column) -> bool:
	for line in range(3):
		if (board[line][column].symbol != current_player.get_symbol()):
			return false
	return true

func check_diagonal(diagonal) -> bool:
	for line in range(3):
		var column
		if diagonal == 0:
			column = line
		else:
			column = 3 - line - 1
		if board[line][column].symbol != current_player.get_symbol():
			return false
	return true

func check_empty_tiles() -> bool:
	var empty_tiles = 0
	for line in range(3):
		for column in range(3):
			if board[line][column].symbol == Player.Symbol.None:
				empty_tiles += 1
	if empty_tiles == 0:
		return true
	else:
		return false

#func check_winner(player: Player) -> bool:
#	print(b)
#	if check_lines(b, player):
#		print("A")
#		winner = player
#		current_player = player_one
#		game_over = true
#		return true
#	if check_columns(b, player):
#		print("B")
#		winner = player
#		current_player = player_one
#		game_over = true
#		return true
#	if check_diagonals(b, player):
#		print("C")
#		winner = player
#		current_player = player_one
#		game_over = true
#		return true
#	if check_empty_tiles(b):
#		print("D")
#		game_over = true
#		current_player = player_one
#		return true
#	return false
#
#func check_lines(player: Player) -> bool:
#	for line in range(3):
#		for column in range(3):
#			if board[line][column].symbol != player.symbol:
#				return false
#	return true
#
#func check_columns(b: Array, player: Player) -> bool:
#	for column in range(3):
#		for line in range(3):
#			if (b[line][column].symbol != player.get_symbol()):
#				return false
#	return true
#
#func check_diagonals(b: Array, player: Player) -> bool:
#	for diagonal in [0, 2]:
#		for line in range(3):
#			var column
#			if diagonal == 0:
#				column = line
#			else:
#				column = 3 - line - 1
#			if b[line][column].symbol != player.get_symbol():
#				return false
#	return true
#
#func check_empty_tiles(b: Array) -> bool:
#	var empty_tiles = 0
#	for line in range(3):
#		for column in range(3):
#			if b[line][column].symbol == Player.Symbol.None:
#				empty_tiles += 1
#	if empty_tiles == 0:
#		return true
#	else:
#		return false
