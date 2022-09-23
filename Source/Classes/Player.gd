class_name Player extends Object

enum Symbol { None = 0, X = 1, O = 2 }

var id: int
var symbol: int

func set_id(new_value: int) -> void:
	id = new_value

func set_symbol(new_value: int) -> void:
	symbol = new_value

func get_symbol() -> int:
	return symbol
