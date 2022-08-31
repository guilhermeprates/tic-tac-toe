extends Control

var start_button: Button
var options_button: Button
var quit_button: Button

func _ready():
	var container = get_node("VBoxContainer")
	start_button = container.get_node("StartButton")
	options_button = container.get_node("OptionsButton")
	quit_button = container.get_node("QuitButton")
	start_button.connect("pressed", self, "on_start_button_pressed")
	options_button.connect("pressed", self, "on_options_button_pressed")
	quit_button.connect("pressed", self, "on_quit_button_pressend")
	start_button.grab_focus()

func on_focus_entered(button):
	button.set("custom_colors/font_color", Color(1,0,0))

func on_start_button_pressed():
	Global.goto_scene("res://Source/Board/Board.tscn")

func on_options_button_pressed():
	pass
	
func on_quit_button_pressend():
	pass