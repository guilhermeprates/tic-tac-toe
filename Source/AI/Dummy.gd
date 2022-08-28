extends Object
class_name Dummy

static func get_move(board) -> BoardTile:
	var empty_tiles = []
	for line in range(3):
		for column in range(3):
			var tile = board[line][column]
			if tile.symbol == Player.Symbol.None:
				empty_tiles.append(tile)
	var random_number_generator = RandomNumberGenerator.new()
	random_number_generator.randomize()
	var random = random_number_generator.randi_range(0, empty_tiles.size() -1)
	var tile = empty_tiles[random]
	print(tile.get_board_position())
	return tile
