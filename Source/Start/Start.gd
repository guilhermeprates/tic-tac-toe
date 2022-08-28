extends Node2D

var start_button: Button

func _ready():
	start_button = get_node("StartButton")
	var _connect = start_button.connect("toggled", self, "start_button_pressed")

func start_button_pressed(toggled):
	if toggled:
		Game.goto_scene("res://Source/Board/Board.tscn")
