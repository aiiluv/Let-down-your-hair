extends Node2D

var total_peluru = 8
var game_selesai = false

# JALUR NODE
@onready var sisa_peluru_label = $CanvasLayer/SisaPeluruLabel
@onready var status_label = $CanvasLayer/StatusLabel
@onready var pistol = $CanvasLayer/Pistol
@onready var marker_peluru = $CanvasLayer/Pistol/Marker2D
@onready var tempat_barang = $CanvasLayer/TempatBarang

# Load file scene peluru
var peluru_scene = preload("res://scenes/game_objects/peluru.tscn")

func _ready():
	game_selesai = false
	update_ui()
	if status_label:
		status_label.hide()

func _process(_delta):
	if game_selesai: return
	
	# Membuat pistol berputar mengikuti arah kursor mouse
	if pistol:
		pistol.look_at(get_global_mouse_position())
	
	# Klik kiri mouse untuk menembak
	if Input.is_action_just_pressed("click") and total_peluru > 0:
		tembak()

func tembak():
	total_peluru -= 1
	update_ui()
	
	if peluru_scene and marker_peluru:
		var peluru_instance = peluru_scene.instantiate()
		peluru_instance.global_position = marker_peluru.global_position
		peluru_instance.arah = (get_global_mouse_position() - marker_peluru.global_position).normalized()
		add_child(peluru_instance)
	
	# KOREKSI: Cek apakah tembakan barusan membuat barang langsung habis
	# Kita beri sedikit jeda 0.1 detik agar antrean queue_free() kucing yang tertembak selesai diproses oleh Godot
	await get_tree().create_timer(0.1).timeout
	if ambil_jumlah_barang_sisa() == 0:
		bikin_menang()
		return
		
	# Jika barang belum habis dan peluru sudah menyentuh angka 0, tunggu evaluasi final kalah
	if total_peluru == 0:
		cek_kondisi_akhir_game()

func ambil_jumlah_barang_sisa() -> int:
	if tempat_barang:
		return tempat_barang.get_child_count()
	return 0

func cek_kondisi_akhir_game():
	# Beri jeda 1.5 detik memberikan kesempatan peluru terakhir terbang mengenai target
	await get_tree().create_timer(1.5).timeout
	
	if game_selesai: return
	
	# Evaluasi Final setelah peluru terakhir selesai meluncur
	if ambil_jumlah_barang_sisa() <= 0:
		bikin_menang()
	else:
		bikin_kalah()

func update_ui():
	if sisa_peluru_label:
		sisa_peluru_label.text = "Bullet: " + str(total_peluru)

func bikin_menang():
	if game_selesai: return
	game_selesai = true
	if status_label:
		status_label.text = "YOU WIN!"
		status_label.modulate = Color.GREEN
		status_label.show()

func bikin_kalah():
	if game_selesai: return
	game_selesai = true
	if status_label:
		status_label.text = "YOU LOSE!"
		status_label.modulate = Color.RED
		status_label.show()
