extends Node2D

@onready var kanvas = $CanvasLayer/TextureRect/Kanvas
@onready var slider_ukuran = %SliderUkuran
@onready var pilih_bentuk = %PilihBentuk
@onready var tombol_fill = %Fill
@onready var button_clear = %ButtonClear

func _ready():
	# Hubungkan fungsi UI baru
	slider_ukuran.value_changed.connect(_on_slider_ukuran_changed)
	pilih_bentuk.item_selected.connect(_on_bentuk_selected)
	tombol_fill.pressed.connect(_on_tombol_fill_pressed)
	button_clear.pressed.connect(_on_button_clear_pressed)

func _on_slider_ukuran_changed(nilai_baru: float):
	if kanvas:
		kanvas.ukuran_kuas = nilai_baru

func _on_bentuk_selected(index: int):
	if kanvas:
		# Mengambil teks item yang dipilih (Kuas, Garis, Kotak, Lingkaran)
		kanvas.mode_bentuk = pilih_bentuk.get_item_text(index)

func _on_tombol_fill_pressed():
	if kanvas:
		kanvas.mode_bentuk = "Fill"

func _on_button_clear_pressed() -> void:
	if kanvas:
		kanvas.hapus_kanvas()
