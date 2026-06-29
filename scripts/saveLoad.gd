extends Node

const save_location = "user://SaveFile.json"

var saveFileData: SaveDataResource = SaveDataResource.new()

var contents_to_save: Dictionary = {
	"progress_bar_value" : 0.0,
	"new_data_to_save" : false
}

func _save():
	ResourceSaver.save(saveFileData, save_location)

func _load():
	if FileAccess.file_exists(save_location):
		saveFileData = ResourceLoader.load(save_location).duplicate(true)

func _ready():
	_load()
#
#func _save():
	#var file = FileAccess.open(save_location, FileAccess.WRITE)
	#file.store_var(contents_to_save.duplicate())
	#file.close()
#
#func _load():
	#if FileAccess.file_exists(save_location):
		#var file = FileAccess.open(save_location, FileAccess.READ)
		#var data = file.get_var()
		#file.close()
		#
		#var save_data = data.duplicate()
		#contents_to_save.progress_bar_value = save_data.progress_bar_value
