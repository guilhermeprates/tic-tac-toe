class_name DifficultyMenu extends Control

onready var easy_button: Button = $VBoxContainer/EasyButton
onready var normal_button: Button = $VBoxContainer/NormalButton
onready var hard_button: Button = $VBoxContainer/HardButton
onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	_setup_connections()

func _on_mouse_entered() -> void:
	audio_stream_player.play()
	
func _on_easy_button_pressed() -> void:
	Global.set_game_level(Game.Level.Easy)
	Global.goto_scene("res://Source/SymbolMenu/SymbolMenu.tscn")

func _on_normal_button_pressed() -> void:
	Global.set_game_level(Game.Level.Normal)
	Global.goto_scene("res://Source/SymbolMenu/SymbolMenu.tscn")
	
func _on_hard_button_pressed() -> void:
	Global.set_game_level(Game.Level.Hard)
	Global.goto_scene("res://Source/SymbolMenu/SymbolMenu.tscn")

func _setup_connections() -> void:
	# warning-ignore:return_value_discarded
	easy_button.connect("pressed", self, "_on_easy_button_pressed")
	# warning-ignore:return_value_discarded
	easy_button.connect("mouse_entered", self, "_on_mouse_entered")
	# warning-ignore:return_value_discarded
	normal_button.connect("pressed", self, "_on_normal_button_pressed")
	# warning-ignore:return_value_discarded
	normal_button.connect("mouse_entered", self, "_on_mouse_entered")
	# warning-ignore:return_value_discarded
	hard_button.connect("pressed", self, "_on_hard_button_pressed")
	# warning-ignore:return_value_discarded
	hard_button.connect("mouse_entered", self, "_on_mouse_entered")
