extends Area2D
class_name BoardTile

signal boardtile_clicked

export(int) var line
export(int) var column
export(Array, Texture) var symbol_textures

var symbol = Player.Symbol.NONE
var sprite

func _ready():
	sprite = get_node("Sprite")
	
func _input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("mouse_left_click"):
		emit_signal("boardtile_clicked", line, column)

func set_symbol(new_symbol):
	symbol = new_symbol
	sprite.texture = symbol_textures[new_symbol]

func get_board_position() -> Vector2:
	return Vector2(line, column)
