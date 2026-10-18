extends CharacterBody2D

@export var gravity: float = 800
@export var base_jump_force: float = -400
@export var perfect_jump_bonus: float = -200

# Variable kendali
@export var move_speed: float = 300
var is_charging_perfect: bool = false
var max_height: float = 0.0

@onready var label_score = %LabelScore

func _physics_process(delta: float) -> void:
	#gerakin kanan - kiri
	var input_x = Input.get_axis("ui_left", "ui_right")
	velocity.x = input_x * move_speed
	
	if input_x != 0:
		%Sprite2D.flip_h = input_x < 0
		
	#menerapkan gravitasi
	if not is_on_floor():
		velocity.y += gravity * delta
	
	#deteksi timing tombol
	if Input.is_action_just_pressed("ui_accept"):
		is_charging_perfect = true
		
	#saat menyentuh kasur
	if is_on_floor():
		if is_charging_perfect:
			# Lompatan Super jika timing tombol pas
			velocity.y = base_jump_force + perfect_jump_bonus
			print("PERFECT JUMP!")
		else:
			# Lompatan Biasa
			velocity.y = base_jump_force
		
		is_charging_perfect = false
	move_and_slide()
	
	#hitung score
	update_score()

func update_score() -> void:
	# Mengukur seberapa tinggi player naik (posisi Y semakin kecil = semakin tinggi)
	var current_height = abs(global_position.y)
	if current_height > max_height:
		max_height = current_height
		if label_score:
			label_score.text = "Tinggi: " + str(int(max_height / 10)) + " m"
	
func _on_game_over_area_body_entered(body: Node2D) -> void:
	#cek jika player terkena area game over
	if body.name == "BedPlayer":
		print("Gameover! Player jatuh dari kasur")
		#ulangi scene saat ini
		get_tree().reload_current_scene()
		
