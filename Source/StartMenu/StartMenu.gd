extends Control

var start_button: Button
var difficulty_button: Button
var quit_button: Button

func _ready():
	var container = get_node("VBoxContainer")
	start_button = container.get_node("StartButton")
	difficulty_button = container.get_node("DifficultyButton")
	quit_button = container.get_node("QuitButton")
	# warning-ignore:return_value_discarded
	start_button.connect("pressed", self, "on_start_button_pressed")
	# warning-ignore:return_value_discarded
	difficulty_button.connect("pressed", self, "on_difficulty_button_pressed")
	# warning-ignore:return_value_discarded
	quit_button.connect("pressed", self, "on_quit_button_pressend")
	start_button.grab_focus()

func on_start_button_pressed():
	Global.goto_scene("res://Source/Board/Board.tscn")

func on_difficulty_button_pressed():
	Global.goto_scene("res://Source/DifficultyMenu/DifficultyMenu.tscn")
	
func on_quit_button_pressend():
	pass
