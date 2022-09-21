extends Control

onready var player_one_score_label: Label = $PlayerOneScoreLabel
onready var player_two_score_label: Label = $PlayerTwoScoreLabel
onready var game_level_label: Label = $GameLevelLabel
onready var game_mode_label: Label = $GameModeLabel
onready var winner_label: Label = $WinnerLabel

func _process(_delta: float) -> void:
	_update_player_one_score()
	_update_player_two_score()
	_update_game_level()
	_update_game_mode()

func _update_player_one_score() -> void:
	var score = String(Global.player_one_score)
	player_one_score_label.text = "Player One Score: " + score

func _update_player_two_score() -> void:
	var score =  String(Global.player_two_score)
	player_two_score_label.text = "Player Two Score: " + score

func _update_game_level() -> void:
	match (Global.game_level):
		Game.Level.Easy:
			game_level_label.text = "Level: Easy"
		Game.Level.Normal:
			game_level_label.text = "Level: Normal"
		Game.Level.Hard:
			game_level_label.text = "Level: Hard"

func _update_game_mode() -> void:
	match (Global.game_mode):
		Game.Mode.PvP:
			game_mode_label.text = "Mode: PvP"
		Game.Mode.PvAI:
			game_mode_label.text = "Mode: PvAI"
		
