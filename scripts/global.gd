extends Node

var lanjut_ke_timeline_7: bool = false
var lanjut_ke_label_done_playing: bool = false
var done_play_festival_games: bool = false
var found_the_truth: bool = false

#menyimpan scene aktif
var current_scene_path: String = "res://scenes/menu/main.tscn"

#untuk mengulang scene terakhir saat di load
func load_saved_scene() -> void:
	if current_scene_path != "":
		get_tree().change_scene_to_file(current_scene_path)
