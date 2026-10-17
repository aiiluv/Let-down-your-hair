extends CharacterBody2D

@export var speed: float = 200

func _physics_process(delta: float) -> void:
	# WASD atau arrow key
	var direction := Vector2.ZERO
	
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	# Normalisasi vektor agar kecepatan diagonal gak lebih cepat
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		
	if direction.x != 0:
		%Sprite2D.flip_h = direction.x < 0
		
	# Mengatur kecepatan dan menggerakkan player
	velocity = direction * speed
	move_and_slide()
