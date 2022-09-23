extends Control

onready var x_button: Button = $HBoxContainer/XButton
onready var o_button: Button = $HBoxContainer/OButton
onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	_setup_connections() 

func _on_mouse_entered() -> void:
	audio_stream_player.play()
	
func _on_x_button_pressed() -> void:
	Global.set_player_one_symbol(Player.Symbol.X)
	Global.set_player_two_symbol(Player.Symbol.O)
	Global.goto_scene("res://Source/Board/Board.tscn")
	
func _on_o_button_pressend() -> void:
	Global.set_player_one_symbol(Player.Symbol.O)
	Global.set_player_two_symbol(Player.Symbol.X)
	Global.goto_scene("res://Source/Board/Board.tscn")

func _setup_connections() -> void:
	# warning-ignore:return_value_discarded
	x_button.connect("pressed", self, "_on_x_button_pressed")
	# warning-ignore:return_value_discarded
	x_button.connect("mouse_entered", self, "_on_mouse_entered")
	# warning-ignore:return_value_discarded
	o_button.connect("pressed", self, "_on_o_button_pressend")
	# warning-ignore:return_value_discarded
	o_button.connect("mouse_entered", self, "_on_mouse_entered")

