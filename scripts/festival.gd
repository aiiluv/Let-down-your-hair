extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_crane_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/games/mini_game_3.tscn")

func _on_shooting_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/games/mini_game_2.tscn")

func _on_can_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/games/mini_game_1.tscn")

func _on_back_btn_pressed() -> void:
	Global.done_play_festival_games = true
	get_tree().change_scene_to_file("res://scenes/menu/main.tscn")

func _on_pause_btn_pressed() -> void:
	Dialogic.paused = true
	var pause_scene = load("res://scenes/menu/pause_menu.tscn")
	var pause_instance = pause_scene.instantiate()
	add_child(pause_instance)
