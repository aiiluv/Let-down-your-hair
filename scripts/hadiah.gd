extends Area2D

signal hadiah_terambil

func _ready():
	# Masukkan hadiah ke dalam Group agar gampang dikenali oleh Crane
	add_to_group("hadiah")

func sukses_terambil():
	emit_signal("hadiah_terambil")
	queue_free() # Hapus boneka karena sudah masuk kantong skor!
