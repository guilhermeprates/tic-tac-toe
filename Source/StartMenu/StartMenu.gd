extends Control

var start_button: Button
var options_button: Button
var quit_button: Button

func _ready():
	var container = get_node("VBoxContainer")
	start_button = container.get_node("StartButton")
	options_button = container.get_node("OptionsButton")
	quit_button = container.get_node("QuitButton")
	var _connected_start = start_button.connect("toggled", self, "on_start_button_pressed")
	var _connected_options = options_button.connect("toggled", self, "on_options_button_pressed")
	var _connected_quit = quit_button.connect("toggled", self, "on_quit_button_pressend")
	start_button.grab_focus()

func on_start_button_pressed(toggled):
	if toggled:
		Global.goto_scene("res://Source/Board/Board.tscn")

func on_options_button_pressed(toggled):
	pass
	
func on_quit_button_pressend(toggled):
	pass
