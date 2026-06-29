extends Node2D

var total_kaleng = 0
var kaleng_jatuh = 0
var bola_dilempar = false

# Ambil referensi ke TextureRect tempat bola & kaleng berada
@onready var texture_rect = $CanvasLayer/TextureRect
@onready var status_label = $StatusLabel

# Gunakan jalur lengkap lewat TextureRect
@onready var bola = $CanvasLayer/TextureRect/Bola2D

func _ready():
	# Menghitung otomatis kaleng yang ada di DALAM TextureRect
	if texture_rect:
		for child in texture_rect.get_children():
			if "Kaleng2D" in child.name:
				total_kaleng += 1
	
	print("Total kaleng terdeteksi: ", total_kaleng)
	
	if status_label:
		status_label.hide()

func _process(_delta):
	if bola_dilempar and bola and status_label and status_label.visible == false:
		if bola.linear_velocity.length() < 10 and bola.freeze == false:
			await get_tree().create_timer(1.5).timeout
			
			# GANTI DI SINI JUGA: Jika bola berhenti dan kaleng jatuh masih kurang dari 3, baru kalah
			if kaleng_jatuh < 3:
				bikin_kalah()

# Fungsi ini dipanggil secara otomatis oleh bola saat dilempar
func set_bola_dilempar():
	bola_dilempar = true

# Fungsi sinyal dari LantaiBawah
func _on_lantai_bawah_body_entered(body: Node) -> void:
	if "Kaleng2D" in body.name:
		kaleng_jatuh += 1
		body.queue_free() 
		
		# GANTI DI SINI: Ubah dari 'total_kaleng' menjadi angka 3
		if kaleng_jatuh >= 3:
			bikin_menang()

func bikin_menang():
	status_label.text = "KAMU MENANG!"
	status_label.modulate = Color.GREEN
	status_label.show()

func bikin_kalah():
	if kaleng_jatuh < total_kaleng:
		status_label.text = "KAMU KALAH!"
		status_label.modulate = Color.RED
		status_label.show()
