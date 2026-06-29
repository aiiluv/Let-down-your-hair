extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_crane_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mini_game_3.tscn")


func _on_shooting_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mini_game_2.tscn")


func _on_can_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mini_game_1.tscn")
