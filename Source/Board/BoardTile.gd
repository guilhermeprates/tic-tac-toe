class_name BoardTile extends Area2D

signal boardtile_selected

export(int) var line
export(int) var column
export(Array, Texture) var symbol_textures

onready var sprite: Sprite = $Sprite

var symbol: int = 0

func _input_event(_viewport: Object, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("mouse_left_click"):
		emit_signal("boardtile_selected", line, column)

func _to_string() -> String:
	return "%d,%d" % [line, column]

func set_symbol(value: int) -> void:
	symbol = value
	sprite.texture = symbol_textures[symbol]

func get_symbol() -> int:
	return symbol
