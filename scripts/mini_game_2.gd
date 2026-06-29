extends Node2D

var total_peluru = 8
var barang_tersisa = 4

# KOREKSI JALUR NODE (Disesuaikan dengan hierarki CanvasLayer di editor)
@onready var sisa_peluru_label = $CanvasLayer/SisaPeluruLabel
@onready var status_label = $CanvasLayer/StatusLabel
@onready var pistol = $CanvasLayer/Pistol
@onready var marker_peluru = $CanvasLayer/Pistol/Marker2D
@onready var tempat_barang = $CanvasLayer/TempatBarang

# Load file scene peluru
var peluru_scene = preload("res://scenes/peluru.tscn")

func _ready():
	update_ui()
	if status_label:
		status_label.hide()
	
	# Menghubungkan sistem deteksi hancur ke semua barang otomatis
	if tempat_barang:
		for barang in tempat_barang.get_children():
			if barang.has_signal("barang_hancur"):
				barang.connect("barang_hancur", _on_barang_hancur)

func _process(_delta):
	# Membuat pistol berputar mengikuti arah kursor mouse
	if pistol:
		pistol.look_at(get_global_mouse_position())
	
	# Klik kiri mouse untuk menembak
	if Input.is_action_just_pressed("click") and total_peluru > 0 and barang_tersisa > 0:
		tembak()

func tembak():
	total_peluru -= 1
	update_ui()
	
	if peluru_scene and marker_peluru:
		var peluru_instance = peluru_scene.instantiate()
		
		# Memunculkan peluru tepat di moncong pistol
		peluru_instance.global_position = marker_peluru.global_position
		
		# Menghitung arah terbang peluru dari pistol menuju posisi mouse saat diklik
		peluru_instance.arah = (get_global_mouse_position() - marker_peluru.global_position).normalized()
		
		# KOREKSI: Masukkan peluru langsung ke scene aktif ini
		add_child(peluru_instance)
	
	# Kondisi cek jika peluru habis
	if total_peluru == 0 and barang_tersisa > 0:
		await get_tree().create_timer(1.5).timeout
		if barang_tersisa > 0:
			bikin_kalah()

func _on_barang_hancur():
	barang_tersisa -= 1
	if barang_tersisa <= 0:
		bikin_menang()

func update_ui():
	if sisa_peluru_label:
		sisa_peluru_label.text = "Peluru: " + str(total_peluru)

func bikin_menang():
	if status_label:
		status_label.text = "KAMU MENANG!"
		status_label.modulate = Color.GREEN
		status_label.show()

func bikin_kalah():
	if barang_tersisa > 0 and status_label:
		status_label.text = "KAMU KALAH!"
		status_label.modulate = Color.RED
		status_label.show()
