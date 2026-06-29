extends Area2D

signal barang_hancur

var hp = 100
@onready var health_bar = $HealthBar

func _ready():
	if health_bar:
		health_bar.value = 100 # Memastikan darah penuh saat game start

# Fungsi yang akan dipanggil saat peluru mengenai barang ini
func terkena_tembakan(damage: int):
	hp -= damage
	if health_bar:
		health_bar.value = hp
	
	if hp <= 0:
		jatuh_dan_hancur()

func jatuh_dan_hancur():
	# Efek animasi jatuh sederhana sebelum hilang
	var tween = create_tween()
	# Barang berputar dan turun ke bawah
	tween.tween_property(self, "position", position + Vector2(0, 300), 0.5)
	tween.parallel().tween_property(self, "rotation_degrees", 90, 0.5)
	
	await tween.finished
	emit_signal("barang_hancur")
	queue_free() # Hapus barang dari game
