extends Node

enum SceneEnum {SIMULATION, ROBOT_EDITOR, SCENE_EDITOR}

var _current_scene: SceneEnum = SceneEnum.SIMULATION

var save_dict = {
	"dll_md5_hash": "",
	"dll_watch_path": "",
	"auto_start_on_load": true
}

var save_path = "res://save_data.save"

signal scene_changed(old_value: SceneEnum, new_value: SceneEnum)

func get_current_scene():
	return _current_scene
func set_current_scene(new_scene: SceneEnum):
	scene_changed.emit(_current_scene, new_scene)
	_current_scene = new_scene

func get_dll_watch_path():
	return save_dict["dll_watch_path"]
func set_dll_watch_path(path: String):
	save_dict["dll_watch_path"] = path
	Save()

func get_dll_md5_hash():
	return save_dict["dll_md5_hash"]
func set_dll_md5_hash(hash: String):
	save_dict["dll_md5_hash"] = hash
	Save()

func get_auto_start_on_load():
	return save_dict["auto_start_on_load"]
func set_auto_start_on_load(val: bool):
	save_dict["auto_start_on_load"] = val
	Save()

func _ready():
	Load()

func Save():
	print("Saving data")
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	var json_string = JSON.stringify(save_dict)
	save_file.store_string(json_string)

func Load():
	print("Loading data")
	if not FileAccess.file_exists(save_path):
		print("Save data file not found.")
		return
	var save_file = FileAccess.open(save_path, FileAccess.READ)
	var save_file_as_text = save_file.get_as_text()
	var content_as_dictionary = JSON.parse_string(save_file_as_text)
	if not content_as_dictionary:
		print("Error parsing save data")
		return
	
	if content_as_dictionary.has("dll_md5_hash"):
		save_dict["dll_md5_hash"] = content_as_dictionary.get("dll_md5_hash")
	if content_as_dictionary.has("dll_watch_path"):
		save_dict["dll_watch_path"] = content_as_dictionary.get("dll_watch_path")
	if content_as_dictionary.has("auto_start_on_load"):
		save_dict["auto_start_on_load"] = content_as_dictionary.get("auto_start_on_load")
