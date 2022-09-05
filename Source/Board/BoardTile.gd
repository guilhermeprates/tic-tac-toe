class_name BoardTile extends Area2D

signal boardtile_clicked

export(int) var line
export(int) var column
export(Array, Texture) var symbol_textures

onready var sprite: Sprite = $Sprite

var symbol: int = 0

func _ready() -> void:
	pass
	
func _input_event(_viewport, event, _shape_idx) -> void:
	if event.is_action_pressed("mouse_left_click"):
		emit_signal("boardtile_clicked", line, column)

func _to_string() -> String:
	return "%d,%d" % [line, column]

func set_symbol(value: int) -> void:
	symbol = value
	sprite.texture = symbol_textures[symbol]

func get_symbol() -> int:
	return symbol
