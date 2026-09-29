extends Node2D

#List Array
@export var list_muka: Array[Texture2D] = []
@export var list_poni: Array[Texture2D] = []
@export var list_rambut: Array[Texture2D] = []
@export var list_baju: Array[Texture2D] = []
@export var list_aksesoris1: Array[Texture2D] = []

#Variable index gambar
var index_muka: int = 0
var index_poni: int = 0
var index_rambut: int = 0
var index_baju: int = 0
var index_aksesoris1: int = 0

#Referensi ke node sprite
@onready var muka_sprite: Sprite2D = %Face
@onready var poni_sprite: Sprite2D = %Poni
@onready var rambut_sprite: Sprite2D = %Hair
@onready var baju_sprite: Sprite2D = %DressBody
@onready var aksesoris1_sprite: Sprite2D = %Accessories1

func _ready() -> void:
	if list_muka.size() > 0:
		muka_sprite.texture = list_muka[index_muka]
		
	if list_poni.size() > 0:
		poni_sprite.texture = list_poni[index_poni]
		
	if list_rambut.size() > 0:
		rambut_sprite.texture = list_rambut[index_rambut]
		
	if list_baju.size() > 0:
		baju_sprite.texture = list_baju[index_baju]
	
	if list_aksesoris1.size() > 0:
		aksesoris1_sprite.texture = list_aksesoris1[index_aksesoris1]

# Fungsi untuk memperbarui gambar berdasarkan index aktif
func update_tampilan() -> void:
	if list_muka.size() > 0:
		muka_sprite.texture = list_muka[index_muka]
	
	if list_poni.size() > 0:
		poni_sprite.texture = list_poni[index_poni]
		
	if list_rambut.size() > 0:
		rambut_sprite.texture = list_rambut[index_rambut]
	
	if list_baju.size() > 0:
		baju_sprite.texture = list_baju[index_baju]
		
	if list_aksesoris1.size() > 0:
		aksesoris1_sprite.texture = list_aksesoris1[index_aksesoris1]

func _on_button_face_pressed() -> void:
	if list_muka.size() == 0: return
	index_muka = (index_muka + 1) % list_muka.size()
	update_tampilan()

func _on_button_poni_pressed() -> void:
	if list_poni.size() == 0: return
	index_poni = (index_poni + 1) % list_poni.size()
	update_tampilan()

func _on_button_hair_pressed() -> void:
	if list_rambut.size() == 0: return
	index_rambut = (index_rambut + 1) % list_rambut.size()
	update_tampilan()
	
func _on_button_dress_pressed() -> void:
	if list_baju.size() == 0: return
	index_baju = (index_baju + 1) % list_baju.size()
	update_tampilan()

func _on_button_accessories_1_pressed() -> void:
	if list_aksesoris1.size() == 0: return
	index_aksesoris1 = (index_aksesoris1 + 1) % list_aksesoris1.size()
	update_tampilan()
