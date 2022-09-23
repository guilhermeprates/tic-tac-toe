class_name StartMenu extends Control

onready var start_button: Button = $VBoxContainer/StartButton
onready var quit_button: Button = $VBoxContainer/QuitButton
onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	_setup_connections()

func _on_mouse_entered() -> void:
	audio_stream_player.play()

func _on_start_button_pressed() -> void:
	Global.reset()
	Global.goto_scene("res://Source/GameModeMenu/GameModeMenu.tscn")
	
func _on_quit_button_pressed() -> void:
	Global.quit()

func _setup_connections() -> void:
	# warning-ignore:return_value_discarded
	start_button.connect("pressed", self, "_on_start_button_pressed")
	# warning-ignore:return_value_discarded
	start_button.connect("mouse_entered", self, "_on_mouse_entered")
	# warning-ignore:return_value_discarded
	quit_button.connect("pressed", self, "_on_quit_button_pressed")
	# warning-ignore:return_value_discarded
	quit_button.connect("mouse_entered", self, "_on_mouse_entered")
