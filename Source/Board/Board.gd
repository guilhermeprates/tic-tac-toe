class_name Board extends Node2D

onready var turn_label: Label = $TurnLabel

var board: Array = []
var tiles: Array = []
var game_over: bool = false
var minimax: Minimax
var player_one: Player
var player_two: Player
var current_player: Player
var winner: Player

func _ready() -> void:
	_start_game()
	_build_board()

func _process(_delta: float) -> void:
	if game_over: 
		_reset_game()
		Global.goto_scene("res://Source/GameOver/GameOver.tscn")

func _start_game() -> void:
	match (Global.game_mode):
		Game.Mode.PvP:
			_start_pvp_game()
		Game.Mode.PvAI:
			_start_pvai_game()

func _start_pvp_game():
	player_one = Player.new()
	player_one.set_id(1)
	player_one.set_symbol(Global.player_one_symbol)
	player_two = Player.new()
	player_two.set_id(2)
	player_two.set_symbol(Global.player_two_symbol)
	current_player = player_one

func _start_pvai_game():
	player_one = Player.new()
	player_one.set_id(1)
	player_one.set_symbol(Global.player_one_symbol)
	player_two = Player.new()
	player_two.set_id(2)
	player_two.set_symbol(Global.player_two_symbol)
	minimax = Minimax.new(player_two, player_one)
	current_player = player_one

func _build_board() -> void:
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
	
func _reset_game() -> void:
	for line in range(3):
		for column in range(3):
			board[line][column] = Player.Symbol.None
	for tile in tiles:
		tile.set_symbol(Player.Symbol.None)
	current_player = player_one
	game_over = false
	turn_label.text = "Player One Turn"

func _update_current_player() -> void:
	if current_player == player_one:
		turn_label.text = "Player Two Turn"
		current_player = player_two
	else:
		turn_label.text = "Player One Turn"
		current_player = player_one
	

func _update_tile_symbol(line: int, column: int, symbol: int) -> void:
	for tile in tiles:
		if tile.line == line and tile.column == column:
			tile.set_symbol(symbol)

func on_boardtile_selected(line: int, column: int) -> void:
	print("%d,%d" % [line, column])

	var symbol = board[line][column]
	if symbol == Player.Symbol.None:
		board[line][column] = current_player.get_symbol()
		_update_tile_symbol(line, column, current_player.get_symbol())
		_check_winner()
		_update_current_player()
	else:
		return
	
	if Global.game_mode == Game.Mode.PvAI:
		if !game_over:
			var board_copy = board.duplicate()
			var move = minimax.get_move(board_copy)
			board[move.x][move.y] = current_player.get_symbol()
			_update_tile_symbol(move.x, move.y, current_player.get_symbol())
			_check_winner()
			_update_current_player()

func _check_winner():
	for line in range(3):
		if _check_line(line):
			print("Winner Line")
			print(current_player)
			Global.set_last_winner(current_player)
			game_over = true
			return
	for column in range(3):
		if _check_column(column):
			print("Winner Column")
			print(current_player)
			Global.set_last_winner(current_player)
			game_over = true
			return
	for diagonal in [0, 2]:
		if _check_diagonal(diagonal):
			print("Winner Diagonal")
			print(current_player)
			Global.set_last_winner(current_player)
			game_over = true
			return
	if _check_empty_tiles():
		print("A tie")
		Global.set_last_winner(null)
		game_over = true
		return

func _check_line(line) -> bool:
	for column in range(3):
		if board[line][column] != current_player.get_symbol():
			return false
	return true
	
func _check_column(column) -> bool:
	for line in range(3):
		if (board[line][column] != current_player.get_symbol()):
			return false
	return true

func _check_diagonal(diagonal) -> bool:
	for line in range(3):
		var column
		if diagonal == 0:
			column = line
		else:
			column = 3 - line - 1
		if board[line][column] != current_player.get_symbol():
			return false
	return true

func _check_empty_tiles() -> bool:
	var empty_tiles = 0
	for line in range(3):
		for column in range(3):
			if board[line][column] == Player.Symbol.None:
				empty_tiles += 1
	if empty_tiles == 0:
		return true
	else:
		return false
