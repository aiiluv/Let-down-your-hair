extends Node2D

func _on_dress_up_pressed():
	get_tree().change_scene_to_file("res://scenes/dress_up_game.tscn")

func _on_window_pressed():
	get_tree().change_scene_to_file("res://scenes/window.tscn")

func _on_paint_pressed():
	get_tree().change_scene_to_file("res://scenes/painting_game.tscn")
