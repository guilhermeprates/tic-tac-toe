extends Area2D
class_name BoardTile

signal boardtile_clicked

export(int) var line
export(int) var column
export(Array, Texture) var player_symbol

var sprite

func _ready():
	sprite = get_node("Sprite")
	
func _input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("mouse_left_click"):
		sprite.texture = player_symbol[1];
		emit_signal("boardtile_clicked", line, column)

func set_symbol(symbol):
	var index = 1
	if symbol == "X":
		index = 2
	sprite.texture = player_symbol[index];

func get_board_position() -> Vector2:
	return Vector2(line, column)
