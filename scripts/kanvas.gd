extends Node2D

var semua_gambar: Array = []
var posisi_awal_klik: Vector2

# Data kuas aktif
var warna_kuas: Color = Color.BLACK
var ukuran_kuas: float = 5.0
var mode_bentuk: String = "Kuas" # Pilihan: Kuas, Garis, Kotak, Lingkaran, Fill
var sedang_menggambar: bool = false

# Penampung sementara saat drag mouse
var garis_sekarang: PackedVector2Array = PackedVector2Array()
var posisi_mouse_sekarang: Vector2

@onready var color_picker = %ColorPickerButton

func _process(_delta):
	if sedang_menggambar:
		posisi_mouse_sekarang = get_local_mouse_position()
		
		if mode_bentuk == "Kuas":
			if garis_sekarang.size() == 0 or garis_sekarang[-1].distance_to(posisi_mouse_sekarang) > 2.0:
				garis_sekarang.append(posisi_mouse_sekarang)
		
		queue_redraw()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if color_picker:
				warna_kuas = color_picker.color
			
			posisi_awal_klik = get_local_mouse_position()
			posisi_mouse_sekarang = posisi_awal_klik
			sedang_menggambar = true
			
			if mode_bentuk == "Kuas":
				garis_sekarang = PackedVector2Array()
				garis_sekarang.append(posisi_awal_klik)
				
			elif mode_bentuk == "Fill":
				# Fitur Fill: Mewarnai seluruh kanvas latar belakang (atau bisa dikembangkan ke area tertutup)
				semua_gambar.append({"jenis": "Fill", "warna": warna_kuas})
				sedang_menggambar = false
				queue_redraw()
		else:
			if sedang_menggambar:
				sedang_menggambar = false
				# Simpan bentuk yang selesai digambar ke dalam database array
				if mode_bentuk == "Kuas" and garis_sekarang.size() > 1:
					semua_gambar.append({"jenis": "Kuas", "titik": garis_sekarang, "warna": warna_kuas, "ukuran": ukuran_kuas})
				elif mode_bentuk == "Garis":
					semua_gambar.append({"jenis": "Garis", "awal": posisi_awal_klik, "akhir": posisi_mouse_sekarang, "warna": warna_kuas, "ukuran": ukuran_kuas})
				elif mode_bentuk == "Kotak":
					semua_gambar.append({"jenis": "Kotak", "awal": posisi_awal_klik, "akhir": posisi_mouse_sekarang, "warna": warna_kuas, "ukuran": ukuran_kuas})
				elif mode_bentuk == "Lingkaran":
					semua_gambar.append({"jenis": "Lingkaran", "awal": posisi_awal_klik, "akhir": posisi_mouse_sekarang, "warna": warna_kuas, "ukuran": ukuran_kuas})
				queue_redraw()

func _draw():
	# 1. Gambar semua objek dari database masa lalu
	for objek in semua_gambar:
		if objek["jenis"] == "Fill":
			draw_rect(Rect2(Vector2.ZERO, get_viewport_rect().size), objek["warna"])
		elif objek["jenis"] == "Kuas":
			draw_polyline(objek["titik"], objek["warna"], objek["ukuran"], true)
		elif objek["jenis"] == "Garis":
			draw_line(objek["awal"], objek["akhir"], objek["warna"], objek["ukuran"], true)
		elif objek["jenis"] == "Kotak":
			var rect = Rect2(objek["awal"], objek["akhir"] - objek["awal"])
			draw_rect(rect, objek["warna"], false, objek["ukuran"])
		elif objek["jenis"] == "Lingkaran":
			var radius = objek["awal"].distance_to(objek["akhir"])
			draw_arc(objek["awal"], radius, 0, TAU, 64, objek["warna"], objek["ukuran"], true)

	# 2. Gambar preview/bentuk yang sedang ditarik mouse secara real-time
	if sedang_menggambar:
		if mode_bentuk == "Kuas" and garis_sekarang.size() > 1:
			draw_polyline(garis_sekarang, warna_kuas, ukuran_kuas, true)
		elif mode_bentuk == "Garis":
			draw_line(posisi_awal_klik, posisi_mouse_sekarang, warna_kuas, ukuran_kuas, true)
		elif mode_bentuk == "Kotak":
			var rect = Rect2(posisi_awal_klik, posisi_mouse_sekarang - posisi_awal_klik)
			draw_rect(rect, warna_kuas, false, ukuran_kuas)
		elif mode_bentuk == "Lingkaran":
			var radius = posisi_awal_klik.distance_to(posisi_mouse_sekarang)
			draw_arc(posisi_awal_klik, radius, 0, TAU, 64, warna_kuas, ukuran_kuas, true)

# KOREKSI: Fungsi untuk menghapus papan tulis/kanvas dengan nama variabel yang baru
func hapus_kanvas():
	semua_gambar.clear() # <- Diubah dari semua_garis menjadi semua_gambar
	garis_sekarang.clear()
	queue_redraw()
