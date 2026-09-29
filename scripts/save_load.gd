extends Control

@export var mode_menu: String = "save" # "save" atau "load"
@onready var slot_grid: GridContainer = $CanvasLayer/TextureRect2/slotGrid

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	setup_slots()

func setup_slots():
	var index = 1
	for button in slot_grid.get_children():
		if button is Button:
			var slot_name = "slot_" + str(index)

			# Disconnect dulu signal lama biar ga double / bentrok
			if button.pressed.is_connected(_on_slot_pressed):
				button.pressed.disconnect(_on_slot_pressed)

			# Connect ulang signal
			button.pressed.connect(_on_slot_pressed.bind(slot_name))
			
			button.vertical_icon_alignment = VerticalAlignment.VERTICAL_ALIGNMENT_TOP
			button.icon_alignment = HorizontalAlignment.HORIZONTAL_ALIGNMENT_CENTER
			button.expand_icon = true

			# Cek status slot
			if Dialogic.Save.has_slot(slot_name):
				var info = Dialogic.Save.get_slot_info(slot_name)
				button.text = "SLOT " + str(index) + "\n[ FILLED ]"
				
				if info.has("thumb_path") and FileAccess.file_exists(info["thumb_path"]):
					var img = Image.load_from_file(info["thumb_path"])
					var text = ImageTexture.create_from_image(img)
					button.icon = text
				
				else: 
					button.icon = null
			else:
				button.text = "SLOT " + str(index) + "\n[ EMPTY ]"
				button.icon = null

			index += 1

func _on_slot_pressed(slot_name: String):
	print("Tombol diklik: ", slot_name) # Cek di Debugger/Output
	
	if mode_menu == "save":
		%CanvasLayer.hide() #Sembunyikan UI sebentar
		
		#sembunyikan juga pause menu
		if get_parent() and get_parent().has_method("hide"):
			get_parent().hide()
		elif get_owner() and get_owner().has_method("hide"):
			get_owner().hide()
		# timer 0.05 detik yang tetap jalan walau game dipause
		await get_tree().create_timer(0.05, true, false, true).timeout
		
		var img = get_viewport().get_texture().get_image()
		var img_path = "user://" + slot_name + "_thumb.png"
		img.save_png(img_path)
		
		%CanvasLayer.show()
		
		#simpan data game dan scene saat ini 
		Dialogic.Save.set_slot_info(slot_name, {
			"thumb_path": img_path,
			"scene_path": Global.current_scene_path
		})
		Dialogic.Save.save(slot_name)
		print("Berhasil save ke: ", slot_name, " di scene: ", Global.current_scene_path)
		
		#update tampilan slot
		setup_slots()
		
		Dialogic.paused =false
		queue_free()
		
	elif mode_menu == "load":
		if Dialogic.Save.has_slot(slot_name):
			var info = Dialogic.Save.get_slot_info(slot_name) #yang kesimpan (sekarang scene ada dimana)
			var target_scene = "res://scenes/menu/main.tscn" # default jika data kosong
			
			if info.has("scene_path"):
				target_scene = info["scene_path"]
				Global.current_scene_path = target_scene #update global path
				
			Dialogic.paused = false
			get_tree().paused = false
			
			#load data dialogic
			Dialogic.Save.load(slot_name)
			queue_free()
			
			#pergi ke scene yang sesuai
			get_tree().change_scene_to_file(target_scene)

func _on_button_back_pressed():
	queue_free()
