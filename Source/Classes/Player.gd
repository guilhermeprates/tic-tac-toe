class_name Player extends Object

enum Symbol { None = 0, X = 1, O = 2 }

var symbol: int

func set_symbol(value: int) -> void:
	symbol = value

func get_symbol() -> int:
	return symbol
