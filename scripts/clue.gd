extends ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%clue.visible = true
	await get_tree().create_timer(2.0).timeout
	%clue.visible = false
 
