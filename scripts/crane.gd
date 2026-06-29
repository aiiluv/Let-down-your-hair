extends Node2D

enum State { BERGERAK_SAMPING, TURUN, NAIK, KEMBALI_AWAL }
var state_sekarang = State.BERGERAK_SAMPING

@export var kecepatan_samping : float = 250.0
@export var kecepatan_turun : float = 400.0
@export var batas_turun_y : float = 500.0 # Seberapa jauh capit meluncur ke bawah

var posisi_awal_y : float
var arah_samping : int = 1
var batas_kiri : float = -300.0
var batas_kanan : float = 300.0

@onready var area_deteksi = $Area2D
var hadiah_terbawa: Area2D = null

func _ready():
	posisi_awal_y = global_position.y
	# Sambungkan sinyal deteksi tabrakan Area2D secara internal kodingan
	if area_deteksi:
		area_deteksi.area_entered.connect(_on_area_2d_area_entered)

func _process(delta):
	match state_sekarang:
		State.BERGERAK_SAMPING:
			# Crane otomatis geser kanan-kiri menanti input player
			position.x += kecepatan_samping * arah_samping * delta
			if position.x >= batas_kanan:
				arah_samping = -1
			elif position.x <= batas_kiri:
				arah_samping = 1
				
			# Tekan SPASI untuk menurunkan capit
			if Input.is_action_just_pressed("ui_accept"):
				state_sekarang = State.TURUN
				
		State.TURUN:
			position.y += kecepatan_turun * delta
			if position.y >= batas_turun_y:
				state_sekarang = State.NAIK # Naik lagi kalau meleset kosong
				
		State.NAIK:
			position.y -= kecepatan_turun * delta
			
			# Jika sedang membawa hadiah, ikut tarik hadiahnya ke atas
			if hadiah_terbawa and is_instance_valid(hadiah_terbawa):
				hadiah_terbawa.global_position = $Marker2D.global_position
				
			if position.y <= posisi_awal_y:
				position.y = posisi_awal_y
				# Jika sukses bawa hadiah sampai atas, panggil fungsi sukses di hadiahnya
				if hadiah_terbawa and is_instance_valid(hadiah_terbawa):
					hadiah_terbawa.sukses_terambil()
					hadiah_terbawa = null
				state_sekarang = State.BERGERAK_SAMPING

func _on_area_2d_area_entered(area: Area2D):
	# Jika capit mendeteksi node Hadiah saat meluncur turun
	if state_sekarang == State.TURUN and area.is_in_group("hadiah"):
		state_sekarang = State.NAIK
		hadiah_terbawa = area
