extends Control

onready var result_label: Label = $ResultLabel
onready var play_again_button: Button = $VBoxContainer/PlayAgainButton
onready var start_menu_button: Button = $VBoxContainer/StartMenuButton
onready var quit_button: Button = $VBoxContainer/QuitButton
onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	_update_result_label()
	_setup_connections()

func _update_result_label() -> void:
	if Global.last_winner != null:
		var winner_symbol = Global.last_winner.get_symbol()
		match (winner_symbol):
			Player.Symbol.X:
				result_label.text = "X won!"
			Player.Symbol.O:
				result_label.text = "O won!"
	else:
		result_label.text = "A tie!"

func _on_mouse_entered() -> void:
	audio_stream_player.play()

func _on_play_again_button_pressed() -> void:
	Global.goto_scene("res://Source/Board/Board.tscn")

func _on_start_menu_button_pressed() -> void:
	Global.goto_scene("res://Source/StartMenu/StartMenu.tscn")

func _on_quit_button_pressed() -> void:
	Global.quit()

func _setup_connections() -> void:
	# warning-ignore:return_value_discarded
	play_again_button.connect("pressed", self, "_on_play_again_button_pressed")
	# warning-ignore:return_value_discarded
	play_again_button.connect("mouse_entered", self, "_on_mouse_entered")
	# warning-ignore:return_value_discarded
	start_menu_button.connect("pressed", self, "_on_start_menu_button_pressed")
	# warning-ignore:return_value_discarded
	start_menu_button.connect("mouse_entered", self, "_on_mouse_entered")
	# warning-ignore:return_value_discarded
	quit_button.connect("pressed", self, "_on_quit_button_pressed")
	# warning-ignore:return_value_discarded
	quit_button.connect("mouse_entered", self, "_on_mouse_entered")
