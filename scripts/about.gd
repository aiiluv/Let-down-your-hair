extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if %ScrollStory : %ScrollStory.visible = false
	if %ScrollCredit : %ScrollCredit.visible = false
	
func _on_story_btn_pressed() -> void:
	%ScrollStory.visible = true
	%ScrollCredit.visible = false

func _on_credit_btn_pressed() -> void:
	%ScrollStory.visible = false
	%ScrollCredit.visible = true
