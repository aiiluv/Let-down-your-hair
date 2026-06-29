extends RigidBody2D

enum Fase {TINGGI, KEKUATAN, SLIDER, SELESAI}
var fase_sekarang = Fase.TINGGI

# Variabel Mekanik
var kecepatan_naik_turun = 300.0
var arah_gerak_y = 1 # 1 artinya turun, -1 artinya naik

var kekuatan_maksimal = 1500.0
var nilai_kekuatan = 0.0
var kecepatan_isi_kekuatan = 3.0
var tambah_kekuatan = true

@export var kekuatan_lempar: float = 0.0
var sudut_lempar: float = 0.0

# Referensi Node UI (Sudah Diperbaiki Jalurnya)
@onready var slider_arah = $"../CanvasLayer/SliderArah"

func _ready():
	# Pastikan bola tidak jatuh di awal game (Spasi gaib sudah dihapus)
	freeze = true
	if slider_arah:
		slider_arah.hide()

func _process(delta):
	match fase_sekarang:
		Fase.TINGGI:
			# Bola otomatis bergerak naik turun di tempatnya
			position.y += kecepatan_naik_turun * arah_gerak_y * delta
			# Batasi area naik turun bola
			if position.y > 400:
				arah_gerak_y = -1
			elif position.y < 100:
				arah_gerak_y = 1
				
		Fase.KEKUATAN:
			# Mengisi bar kekuatan naik dan turun otomatis
			if tambah_kekuatan:
				nilai_kekuatan += kecepatan_isi_kekuatan * delta
				if nilai_kekuatan >= 1.0: tambah_kekuatan = false
			else:
				nilai_kekuatan -= kecepatan_isi_kekuatan * delta
				if nilai_kekuatan <= 0.0: tambah_kekuatan = true

			# BENAR 
			$ColorRect.modulate = Color(1.0, 1.0 - nilai_kekuatan, 1.0 - nilai_kekuatan)

		Fase.SLIDER:
			# Mengambil nilai sudut dari slider
			if slider_arah:
				sudut_lempar = slider_arah.value

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		match fase_sekarang:
			Fase.TINGGI:
				# Klik 1: Kunci Ketinggian
				fase_sekarang = Fase.KEKUATAN
				print("Ketinggian dikunci! Sekarang pilih kekuatan.")
				
			Fase.KEKUATAN:
				# Klik 2: Kunci Kekuatan
				kekuatan_lempar = nilai_kekuatan * kekuatan_maksimal
				fase_sekarang = Fase.SLIDER
				if slider_arah:
					slider_arah.show()
				print("Kekuatan dikunci! Geser slider untuk melempar.")

func lempar_bola():
	if fase_sekarang == Fase.SLIDER:
		fase_sekarang = Fase.SELESAI
		if slider_arah:
			slider_arah.hide()
		freeze = false
		
		var arah = Vector2(1, sudut_lempar * 0.5).normalized()
		apply_central_impulse(arah * kekuatan_lempar)
		
		# TAMBAHKAN BARIS INI:
		get_tree().current_scene.set_bola_dilempar()

func _on_lempar_pressed() -> void:
	lempar_bola()
