extends Control

var easy_button: Button
var normal_button: Button
var hard_button: Button
var audio_stream_player: AudioStreamPlayer

func _ready() -> void:
	audio_stream_player = get_node("AudioStreamPlayer")
	var container = get_node("VBoxContainer")
	easy_button = container.get_node("EasyButton")
	normal_button = container.get_node("NormalButton")
	hard_button = container.get_node("HardButton")
	setup_connections()
	grab_focus_on_current_level_button()

func grab_focus_on_current_level_button():
	match (Global.level):
		Difficulty.Level.Easy:
			easy_button.grab_focus()
		Difficulty.Level.Normal:
			normal_button.grab_focus()
		Difficulty.Level.Hard:
			hard_button.grab_focus()

func on_focus_exited():
	audio_stream_player.play()
	
func on_easy_button_pressed():
	Global.set_level(Difficulty.Level.Easy)
	Global.goto_scene("res://Source/StartMenu/StartMenu.tscn")

func on_normal_button_pressed():
	Global.set_level(Difficulty.Level.Normal)
	Global.goto_scene("res://Source/StartMenu/StartMenu.tscn")
	
func on_hard_button_pressed():
	Global.set_level(Difficulty.Level.Hard)
	Global.goto_scene("res://Source/StartMenu/StartMenu.tscn")

func setup_connections():
	# warning-ignore:return_value_discarded
	easy_button.connect("pressed", self, "on_easy_button_pressed")
	# warning-ignore:return_value_discarded
	easy_button.connect("focus_exited", self, "on_focus_exited")
	# warning-ignore:return_value_discarded
	normal_button.connect("pressed", self, "on_normal_button_pressed")
	# warning-ignore:return_value_discarded
	normal_button.connect("focus_exited", self, "on_focus_exited")
	# warning-ignore:return_value_discarded
	hard_button.connect("pressed", self, "on_hard_button_pressed")
	# warning-ignore:return_value_discarded
	hard_button.connect("focus_exited", self, "on_focus_exited")
