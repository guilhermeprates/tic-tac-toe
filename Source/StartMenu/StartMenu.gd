class_name StartMenu extends Control

onready var start_button: Button = $VBoxContainer/StartButton
onready var quit_button: Button = $VBoxContainer/QuitButton
onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	setup_connections()

func on_mouse_entered() -> void:
	audio_stream_player.play()

func on_start_button_pressed() -> void:
	Global.goto_scene("res://Source/GameModeMenu/GameModeMenu.tscn")
	
func on_quit_button_pressend() -> void:
	Global.quit()

func setup_connections() -> void:
	# warning-ignore:return_value_discarded
	start_button.connect("pressed", self, "on_start_button_pressed")
	# warning-ignore:return_value_discarded
	start_button.connect("mouse_entered", self, "on_mouse_entered")
	# warning-ignore:return_value_discarded
	quit_button.connect("pressed", self, "on_quit_button_pressend")
	# warning-ignore:return_value_discarded
	quit_button.connect("mouse_entered", self, "on_mouse_entered")
