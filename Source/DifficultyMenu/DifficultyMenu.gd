class_name DifficultyMenu extends Control

onready var easy_button: Button = $VBoxContainer/EasyButton
onready var normal_button: Button = $VBoxContainer/NormalButton
onready var hard_button: Button = $VBoxContainer/HardButton
onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	setup_connections()
	grab_focus_on_current_level_button()

func grab_focus_on_current_level_button() -> void:
	match (Global.level):
		Difficulty.Level.Easy:
			easy_button.grab_focus()
		Difficulty.Level.Normal:
			normal_button.grab_focus()
		Difficulty.Level.Hard:
			hard_button.grab_focus()

func on_focus_exited() -> void:
	audio_stream_player.play()
	
func on_easy_button_pressed() -> void:
	Global.set_level(Difficulty.Level.Easy)
	Global.goto_scene("res://Source/StartMenu/StartMenu.tscn")

func on_normal_button_pressed() -> void:
	Global.set_level(Difficulty.Level.Normal)
	Global.goto_scene("res://Source/StartMenu/StartMenu.tscn")
	
func on_hard_button_pressed() -> void:
	Global.set_level(Difficulty.Level.Hard)
	Global.goto_scene("res://Source/StartMenu/StartMenu.tscn")

func setup_connections() -> void:
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
