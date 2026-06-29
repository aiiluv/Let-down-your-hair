extends Area2D

var kecepatan = 800
var arah = Vector2.ZERO
var damage = 50 # 2 kali tembak per barang langsung rontok!

func _process(delta):
	# Gerakkan peluru lurus sesuai arah tembakan pistol
	position += arah * kecepatan * delta

func _on_area_entered(area: Area2D) -> void:
	# Jika peluru menabrak objek yang punya fungsi terkena_tembakan (barang)
	if area.has_method("terkena_tembakan"):
		area.terkena_tembakan(damage)
		queue_free() # Hapus peluru setelah kena sasaran

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # Hapus peluru kalau meleset keluar layar biar tidak lag
