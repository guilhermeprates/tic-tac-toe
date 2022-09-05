class_name StartMenu extends Control

var start_button: Button
var difficulty_button: Button
var quit_button: Button
var audio_stream_player: AudioStreamPlayer

func _ready() -> void:
	audio_stream_player = get_node("AudioStreamPlayer")
	var container = get_node("VBoxContainer")
	start_button = container.get_node("StartButton")
	difficulty_button = container.get_node("DifficultyButton")
	quit_button = container.get_node("QuitButton")
	setup_connections()
	start_button.grab_focus()

func on_focus_exited() -> void:
	audio_stream_player.play()

func on_start_button_pressed() -> void:
	Global.goto_scene("res://Source/Board/Board.tscn")

func on_difficulty_button_pressed() -> void:
	Global.goto_scene("res://Source/DifficultyMenu/DifficultyMenu.tscn")
	
func on_quit_button_pressend() -> void:
	Global.quit()

func setup_connections() -> void:
	# warning-ignore:return_value_discarded
	start_button.connect("pressed", self, "on_start_button_pressed")
	# warning-ignore:return_value_discarded
	start_button.connect("focus_exited", self, "on_focus_exited")
	# warning-ignore:return_value_discarded
	difficulty_button.connect("pressed", self, "on_difficulty_button_pressed")
	# warning-ignore:return_value_discarded
	difficulty_button.connect("focus_exited", self, "on_focus_exited")
	# warning-ignore:return_value_discarded
	quit_button.connect("pressed", self, "on_quit_button_pressend")
	# warning-ignore:return_value_discarded
	quit_button.connect("focus_exited", self, "on_focus_exited")
