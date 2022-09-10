class_name Minimax extends Object

const BOARD_SIZE: int = 3

var minimax: Player
var opponent: Player

func _init(new_minimax: Player, new_opponent: Player) -> void:
	self.minimax = new_minimax
	self.opponent = new_opponent
	
func get_move(board: Array) -> Vector2:
	var best_score = -INF
	var move: Vector2
	for line in range(BOARD_SIZE):
		for column in range(BOARD_SIZE):
			if board[line][column] == Player.Symbol.None:
				board[line][column] = minimax.get_symbol()
				var depth = _count_empty_positions(board)
				var score = _minimax(board, opponent, depth)
				if score > best_score:
					best_score = score
					move = Vector2(line, column)
				board[line][column] = Player.Symbol.None
	return move

func _minimax(board: Array, player: Player, depth: int) -> int:
	
	var result = _utility(board, depth)
	if result != 2:
		return result
		
	if player == minimax:
		var best_score = -INF
		for line in range(BOARD_SIZE):
			for column in range(BOARD_SIZE):
				if board[line][column] == Player.Symbol.None:
					board[line][column] = minimax.get_symbol()
					var score = _minimax(board, opponent, depth - 1)
					best_score = max(score, best_score)
					board[line][column] = Player.Symbol.None
		return best_score
	else:
		var best_score = INF
		for line in range(BOARD_SIZE):
			for column in range(BOARD_SIZE):
				if board[line][column] == Player.Symbol.None:
					board[line][column] = opponent.get_symbol()
					var score = _minimax(board, minimax, depth - 1)
					best_score = min(score, best_score)
					board[line][column] = Player.Symbol.None
		return best_score

func _utility(board: Array, depth: int) -> int:
	if _check_winner(board, minimax): return 1
	if _check_winner(board, opponent): return -1
	if depth == 0: return 0
	return 2

func _count_empty_positions(board: Array) -> int:
	var count = 0
	for line in range(BOARD_SIZE):
		for column in range(BOARD_SIZE):
			if board[line][column] == Player.Symbol.None:
				count += 1 
	return count

func _check_winner(board: Array, player: Player):
	for line in range(3):
		if _check_line(line, board, player):
			return true
	for column in range(3):
		if _check_column(column, board, player):
			return true
	for diagonal in [0, 2]:
		if _check_diagonal(diagonal, board, player):
			return true
	return false

func _check_line(line, board, player) -> bool:
	for column in range(3):
		if board[line][column] != player.get_symbol():
			return false
	return true
	
func _check_column(column,  board, player) -> bool:
	for line in range(3):
		if (board[line][column] != player.get_symbol()):
			return false
	return true

func _check_diagonal(diagonal, board, player) -> bool:
	for line in range(3):
		var column
		if diagonal == 0:
			column = line
		else:
			column = 3 - line - 1
		if board[line][column] != player.get_symbol():
			return false
	return true
