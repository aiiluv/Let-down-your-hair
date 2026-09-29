extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_start_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main.tscn")

func _on_save_btn_pressed() -> void:
	var save_scene = load("res://scenes/menu/save.tscn")
	var save_instance = save_scene.instantiate()
	
	#set mode menu ke load
	save_instance.mode_menu = "load"
	add_child(save_instance) #munculkan dilayar
