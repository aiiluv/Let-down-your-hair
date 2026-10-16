extends Node2D

func _on_dress_up_pressed():
	get_tree().change_scene_to_file("res://scenes/games/dress_up_game.tscn")

func _on_window_pressed():
	Global.lanjut_ke_label_done_playing = true
	get_tree().change_scene_to_file("res://scenes/menu/main.tscn")

func _on_paint_pressed():
	get_tree().change_scene_to_file("res://scenes/games/painting_game.tscn")
	
func _on_pause_btn_pressed() -> void:
	Dialogic.paused = true
	var pause_scene = load("res://scenes/menu/pause_menu.tscn")
	var pause_instance = pause_scene.instantiate()
	add_child(pause_instance)
