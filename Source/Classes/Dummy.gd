class_name Dummy extends Object

const BOARD_SIZE: int = 3

static func get_move(tiles: Array) -> Vector2:
	var empty_tiles = []
	for tile in tiles:
		if tile.get_symbol() == Player.Symbol.None:
			empty_tiles.append(tile)
	var random_number_generator = RandomNumberGenerator.new()
	random_number_generator.randomize()
	var random = random_number_generator.randi_range(0, empty_tiles.size() -1)
	var tile = empty_tiles[random]
	return Vector2(tile.line, tile.column)
