extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS #WAJIB!! agar tombol pause bisa di klik saat game di pause

func _on_resume_btn_pressed() -> void:
	Dialogic.paused = false
	queue_free() #tutup menu pause

func _on_save_btn_pressed() -> void:
	hide() #sembunyikan pause menu
	await get_tree().create_timer(0.05, true, false, true).timeout
	var img = get_viewport().get_texture().get_image() #Tangkap layar gameplay murni
	img.save_png("user://temp_screenshot.png")
	
	var save_scene = load("res://scenes/menu/save.tscn").instantiate()
	get_tree().root.add_child(save_scene)
	queue_free()

func _on_home_btn_pressed() -> void:
	Dialogic.end_timeline() #matikan dialogic scr bersih
	Dialogic.paused = false
	
	get_tree().change_scene_to_file("res://scenes/menu/menu_screen.tscn")
