extends Node2D

func _ready() -> void:
	%locked.visible = false

func _on_to_tower_pressed() -> void:
	Global.lanjut_ke_timeline_7 = true
	get_tree().change_scene_to_file("res://scenes/menu/main.tscn")

func _on_to_market_pressed() -> void:
	%locked.visible = true
	await get_tree().create_timer(2.0).timeout
	%locked.visible = false
	
func _on_to_forest_pressed() -> void:
	%locked.visible = true
	await get_tree().create_timer(2.0).timeout
	%locked.visible = false

func _on_to_river_pressed() -> void:
	%locked.visible = true
	await get_tree().create_timer(2.0).timeout
	%locked.visible = false
