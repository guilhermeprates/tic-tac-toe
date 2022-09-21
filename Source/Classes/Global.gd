extends Node

var game_level: int = 1
var game_mode: int = 0
var player_one_score: int = 0
var player_two_score: int = 0
var current_scene = null

func _ready() -> void:
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path: String) -> void:
	call_deferred("_deferred_goto_scene", path)

func set_game_mode(new_value: int) -> void:
	game_mode = new_value

func set_game_level(new_value: int) -> void:
	game_level = new_value

func set_player_one_score(new_value: int) -> void:
	player_one_score = new_value

func set_player_two_score(new_value: int) -> void:
	player_two_score = new_value

func reset() -> void:
	player_one_score = 0
	player_two_score = 0
	game_level = 1
	game_mode = 0
	
func quit() -> void:
	get_tree().quit()
	
func _deferred_goto_scene(path: String) -> void:
	# It is now safe to remove the current scene
	current_scene.free()
	# Load the new scene.
	var s = ResourceLoader.load(path)
	# Instance the new scene.
	current_scene = s.instance()
	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
