extends Node2D

#Var api
@export var max_fire: float = 100
@export var min_fire: float = 0
var current_fire: float = 50
var score_timer: int = 0
var game_over: bool = false

@onready var fire_bar: ProgressBar = %FireBar
@onready var label_score: Label = %LabelScore
@onready var fire_timer: Timer = %FireTimer

func _ready() -> void:
	#atur batas nilai ProgressBar
	if fire_bar:
		fire_bar.max_value = max_fire
		fire_bar.value = current_fire
		
	#hubungkan ke timer secara otomatis
	fire_timer.timeout.connect(_on_fire_timer_timeout)
	
func _process(delta: float) -> void:
	if game_over:
		return
		
	#Update tampilan UI
	if fire_bar:
		fire_bar.value = current_fire
	if label_score:
		label_score.text = "Waktu bertahan: " + str(score_timer) + " detik"
	
	#cek kondisi kalah
	if current_fire <= min_fire:
		trigger_game_over("Api padam! Ruangan kedinginan")
	if current_fire >= max_fire:
		trigger_game_over("Api membesar! Ruangan kebakaran")

func _on_fire_timer_timeout() -> void:
	if game_over:
		return
		
	#Api alami berkurang 5 poin / detik
	current_fire -= 5
	score_timer += 1
	
#Tombol kayu
func _on_btn_normal_wood_pressed() -> void:
	if not game_over:
		current_fire += 15
		print("menambahkan kayu biasa")

func _on_btn_dry_wood_pressed() -> void:
	if not game_over:
		current_fire += 35
		print("menambahkan kayu kering")

func _on_btn_wet_wood_pressed() -> void:
	if not game_over:
		current_fire -= 15
		print("menambahkan kayu basah")

#Gameover
func trigger_game_over(reason: String) -> void:
	game_over = true
	fire_timer.stop()
	print("Gameover: ", reason)
	
	#ulangi game setelah 2 detik
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()
