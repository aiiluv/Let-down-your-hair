extends Node2D

func _ready() -> void:
	%locked.visible = false

func _on_books_pressed() -> void:
	%locked.visible = true
	await get_tree().create_timer(2.0).timeout
	%locked.visible = false

func _on_explore_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/explore.tscn")

func _on_bed_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/games/Castle/bed.tscn")

func _on_perapian_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/games/Castle/perapian.tscn")

func _on_pause_btn_pressed() -> void:
	Dialogic.paused = true
	var pause_scene = load("res://scenes/menu/pause_menu.tscn")
	var pause_instance = pause_scene.instantiate()
	add_child(pause_instance)
