extends Node
class_name BoardTile

signal set_symbol

var symbol: String

func _init():
	self.symbol = ''

func set_position(position: Vector2) -> void:
	self.position = position

func set_symbol(new_symbol: String) -> void:
	self.symbol = new_symbol
	emit_signal("set_symbol")

