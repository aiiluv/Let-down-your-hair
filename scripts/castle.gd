extends Node2D

func _on_books_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/books.tscn")

func _on_explore_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/explore.tscn")
