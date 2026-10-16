extends Node2D

@export var minigame_scene: PackedScene

func _ready() -> void:
	Dialogic.paused = false
	Dialogic.signal_event.connect(_on_dialogic_signal) # Menghubungkan signal dari dialogic
	
	# Cek apakah pemain baru balik dari castle
	if Global.lanjut_ke_timeline_7:
		Global.lanjut_ke_timeline_7 = false 
		Dialogic.start("timeline7")
		
	# Cek apakah pemain baru balik dari tower
	elif Global.lanjut_ke_label_done_playing:
		Global.lanjut_ke_label_done_playing = false
		Dialogic.start("timeline9", "done_playing")
	
	#main di festival
	elif Global.done_play_festival_games:
		Global.done_play_festival_games = false
		Dialogic.start("timeline10")
	
	#ketemu history dari ke2 bunga
	elif Global.found_the_truth:
		Global.found_the_truth = false
		
		var current_timeline = Dialogic.start("timeline11")
		if current_timeline:
			Dialogic.Jump.jump_to_label("found_the_truth")
		
	# Kalau bukan dari keduanya dan belum ada timeline jalan, mulai dari awal
	elif Dialogic.current_timeline == null:
		Dialogic.start("timeline1")

func _on_dialogic_signal(argument: String) -> void:
	print("Sinyal diterima dari Dialogic dengan argumen: ", argument)
	
	if argument == "start_inside_castle":
		print("Berpindah ke castle.tscn")
		Dialogic.clear() # Membersihkan sesi dialogic
		Global.current_scene_path = "res://scenes/castle.tscn"
		#simpan scene sekarang ke slot save aktif dialogic
		Dialogic.Save.save_file("default", "current_scene.txt", Global.current_scene_path)
		get_tree().change_scene_to_file(Global.current_scene_path)
		
	elif argument == "play_inside_tower":
		print("Berpindah ke tower.tscn")
		Dialogic.clear() # Membersihkan sesi dialogic
		Global.current_scene_path = "res://scenes/tower.tscn"
		#simpan scene sekarang ke slot save aktif dialogic
		Dialogic.Save.save_file("default", "current_scene.txt", Global.current_scene_path)
		get_tree().change_scene_to_file(Global.current_scene_path)
		
	elif argument == "festival_games":
		print("Berpindah ke festival.tscn")
		Dialogic.clear()
		Global.current_scene_path = "res://scenes/festival.tscn"
		#simpan scene sekarang ke slot save aktif dialogic
		Dialogic.Save.save_file("default", "current_scene.txt", Global.current_scene_path)
		get_tree().change_scene_to_file(Global.current_scene_path)
		
	elif argument == "DONE":
		print("Game selesai! Pindah ke ending scene")
		Dialogic.clear()
		Global.current_scene_path = "res://scenes/menu/ending.tscn"
		Dialogic.Save.save_file("default", "current_scene.txt", Global.current_scene_path)
		get_tree().change_scene_to_file(Global.current_scene_path)

func _on_pause_btn_pressed() -> void:
	Dialogic.paused = true
	var pause_scene = load("res://scenes/menu/pause_menu.tscn")
	var pause_instance = pause_scene.instantiate()
	add_child(pause_instance)
