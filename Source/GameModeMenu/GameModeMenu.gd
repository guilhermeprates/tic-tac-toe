class_name GameModeMenu extends Control

onready var pvp_button: Button = $VBoxContainer/PvPButton
onready var pvai_button: Button = $VBoxContainer/PvAIButton
onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	setup_connections()

func on_mouse_entered() -> void:
	audio_stream_player.play()

func on_pvp_button_button_pressed() -> void:
	Global.set_game_mode(Game.Mode.PvP)
	Global.goto_scene("res://Source/Board/Board.tscn")
	
func on_pvai_button_pressed() -> void:
	Global.set_game_mode(Game.Mode.PvAI)
	Global.goto_scene("res://Source/DifficultyMenu/DifficultyMenu.tscn")

func setup_connections() -> void:
	# warning-ignore:return_value_discarded
	pvp_button.connect("pressed", self, "on_pvp_button_button_pressed")
	# warning-ignore:return_value_discarded
	pvp_button.connect("mouse_entered", self, "on_mouse_entered")
	# warning-ignore:return_value_discarded
	pvai_button.connect("pressed", self, "on_pvai_button_pressed")
	# warning-ignore:return_value_discarded
	pvai_button.connect("mouse_entered", self, "on_mouse_entered")
