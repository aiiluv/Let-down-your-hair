extends Line2D

@export var panjang_maksimal: int = 15
@onready var bola = get_parent()

func _process(_delta):
	# Selalu bersihkan rotasi global agar garis tidak melintir
	global_rotation = 0
	
	# Tambahkan posisi bola saat ini ke dalam daftar titik garis
	add_point(bola.global_position)
	
	# Jika titik garis terlalu panjang, hapus titik yang paling lama
	while points.size() > panjang_maksimal:
		remove_point(0)
