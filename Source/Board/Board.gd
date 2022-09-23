class_name Board extends Area2D

const BOARD_SIZE: int = 3

onready var turn_label: Label = $TurnLabel

var board: Array = []
var tiles: Array = []
var game_over: bool = false
var minimax: Minimax
var player_one: Player
var player_two: Player
var current_player: Player
var winner: Player
var game_mode: int

func _ready() -> void:
	game_mode = Global.game_mode
	_start_game()
	_build_board()

func _process(_delta: float) -> void:
	if !game_over && game_mode == Game.Mode.PvAI: 
		if current_player == player_two:
			_ia_move()

func _input_event(_viewport: Object, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("mouse_left_click"):
		if game_over:
			_reset_game()
			Global.goto_scene("res://Source/GameOver/GameOver.tscn")\

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
	_radomize_first()

func _start_pvai_game():
	player_one = Player.new()
	player_one.set_id(1)
	player_one.set_symbol(Global.player_one_symbol)
	player_two = Player.new()
	player_two.set_id(2)
	player_two.set_symbol(Global.player_two_symbol)
	minimax = Minimax.new(player_two, player_one)
	_radomize_first()

func _radomize_first() -> void:
	var players = [player_one, player_two]
	var random_number_generator = RandomNumberGenerator.new()
	random_number_generator.randomize()
	var random = random_number_generator.randi_range(0, players.size() -1)
	current_player = players[random]

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
	for line in range(BOARD_SIZE):
		for column in range(BOARD_SIZE):
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
	
	if game_over:
		return
		
	var symbol = board[line][column]
	if symbol == Player.Symbol.None:
		board[line][column] = current_player.get_symbol()
		_update_tile_symbol(line, column, current_player.get_symbol())
		_check_winner()
		_update_current_player()
	else:
		return

func _ia_move() -> void:
	var move = _get_move()
	board[move.x][move.y] = current_player.get_symbol()
	_update_tile_symbol(move.x, move.y, current_player.get_symbol())
	_check_winner()
	_update_current_player()

func _get_move() -> Vector2:
	match(Global.game_level):
		Game.Level.Easy:
			var percent = randf()
			if percent <= 0.25:
				print("Minimax")
				return _get_minimax_move()
			else:
				print("Dummy")
				return _get_dummy_move()
		Game.Level.Normal:
			var percent = randf()
			if percent <= 0.5:
				print("Minimax")
				return _get_minimax_move()
			else:
				print("Dummy")
				return _get_dummy_move()
		_:
			return _get_minimax_move()

func _get_dummy_move() -> Vector2:
	return Dummy.get_move(tiles)
	
func _get_minimax_move() -> Vector2:
	var board_copy = board.duplicate()
	return minimax.get_move(board_copy)

func _check_winner():
	for line in range(3):
		if _check_line(line):
			print("Winner(Line)")
			print(current_player)
			Global.set_last_winner(current_player)
			game_over = true
			return
	for column in range(3):
		if _check_column(column):
			print("Winner(Column)")
			print(current_player)
			Global.set_last_winner(current_player)
			game_over = true
			return
	for diagonal in [0, 2]:
		if _check_diagonal(diagonal):
			print("Winner(Diagonal)")
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
	for column in range(BOARD_SIZE):
		if board[line][column] != current_player.get_symbol():
			return false
	return true
	
func _check_column(column) -> bool:
	for line in range(BOARD_SIZE):
		if (board[line][column] != current_player.get_symbol()):
			return false
	return true

func _check_diagonal(diagonal) -> bool:
	for line in range(BOARD_SIZE):
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
	for line in range(BOARD_SIZE):
		for column in range(BOARD_SIZE):
			if board[line][column] == Player.Symbol.None:
				empty_tiles += 1
	if empty_tiles == 0:
		return true
	else:
		return false
