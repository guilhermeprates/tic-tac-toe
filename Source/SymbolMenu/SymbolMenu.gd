extends Control

onready var x_button: Button = $Background/HBoxContainer/XButton
onready var o_button: Button = $Background/HBoxContainer/OButton
onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	setup_connections()

func on_mouse_entered() -> void:
	audio_stream_player.play()
	
func on_x_button_pressed() -> void:
	Global.goto_scene("res://Source/Board/Board.tscn")
	
func on_o_button_pressend() -> void:
	Global.goto_scene("res://Source/Board/Board.tscn")

func setup_connections() -> void:
	# warning-ignore:return_value_discarded
	x_button.connect("pressed", self, "on_x_button_pressed")
	# warning-ignore:return_value_discarded
	x_button.connect("mouse_entered", self, "on_mouse_entered")
	# warning-ignore:return_value_discarded
	o_button.connect("pressed", self, "on_o_button_pressend")
	# warning-ignore:return_value_discarded
	o_button.connect("mouse_entered", self, "on_mouse_entered")

