extends Button

#skala awal dan saat menyentuh mouse
var skala_normal: Vector2 = Vector2(1.0, 1.0)
var skala_hover: Vector2 = Vector2(1.1, 1.1)

#warna normal dan saat menyentuh mouse
var warna_normal: Color = Color(1, 1, 1, 1)
var warna_glow: Color = Color(1.8, 1.8, 1.8, 1)

var tween_skala: Tween
var tween_warna: Tween

func _ready():
	pivot_offset = size / 2
	scale = skala_normal
	self_modulate = warna_normal

func _process(_delta):
	if is_hovered():
		if tween_skala == null or not tween_skala.is_running():
			mulai_animasi(skala_hover, warna_glow)
	else:
		if scale != skala_normal and (tween_skala == null or not tween_skala.is_running()):
			mulai_animasi(skala_normal, warna_normal)

func mulai_animasi(target_skala: Vector2, target_warna: Color):
	if tween_skala: tween_skala.kill()
	if tween_warna: tween_warna.kill()
	
	tween_skala = create_tween()
	tween_warna = create_tween()
	
	#efek transisi halus selama 0.15 detik
	tween_skala.tween_property(self, "scale", target_skala, 0.15).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween_warna.tween_property(self, "self_modulate", target_warna, 0.15).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
