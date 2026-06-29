extends Node2D

var skor = 0
var total_hadiah = 3

@onready var score_label = $CanvasLayer/ScoreLabel
@onready var status_label = $CanvasLayer/StatusLabel
@onready var tempat_hadiah = $TempatHadiah

func _ready():
	update_ui()
	if status_label:
		status_label.hide()
	
	# Menghubungkan deteksi jika ada hadiah yang sukses diambil
	if tempat_hadiah:
		for hadiah in tempat_hadiah.get_children():
			if hadiah.has_signal("hadiah_terambil"):
				hadiah.connect("hadiah_terambil", _on_hadiah_terambil)

func _on_hadiah_terambil():
	skor += 1
	update_ui()
	if skor >= total_hadiah:
		bikin_menang()

func update_ui():
	if score_label:
		score_label.text = "Skor: " + str(skor)

func bikin_menang():
	if status_label:
		status_label.text = "KAMU MENANG!"
		status_label.modulate = Color.GREEN
		status_label.show()
