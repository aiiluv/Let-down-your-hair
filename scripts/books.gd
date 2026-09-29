extends Control

func _ready() -> void:
	if %story_ch1: %story_ch1.visible = false
	if %story_ch2: %story_ch2.visible = false
	if %story_ch3: %story_ch3.visible = false
	if %story_ch4: %story_ch4.visible = false

func _on_story_ch_1_pressed() -> void:
	%story_ch1.visible = false
	
func _on_story_ch_2_pressed() -> void:
	%story_ch2.visible = false

func _on_story_ch_3_pressed() -> void:
	%story_ch3.visible = false

func _on_story_ch_4_pressed() -> void:
	%story_ch4.visible = false

func _on_done_btn_pressed() -> void:
	Global.found_the_truth = true
	get_tree().change_scene_to_file("res://scenes/menu/main.tscn")
