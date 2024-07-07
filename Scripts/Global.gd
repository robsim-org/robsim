extends Node

enum Scene_enum {SIMULATION, ROBOT_EDITOR, SCENE_EDITOR}

var _dll_watch_path: String = ""
var _dll_md5_hash: String = ""

var save_path = "res://save_data.save"
var _current_scene: Scene_enum = Scene_enum.SIMULATION

func get_dll_watch_path():
	return _dll_watch_path
	
func set_dll_watch_path(path: String):
	_dll_watch_path = path
	Save()

func get_dll_md5_hash():
	return _dll_md5_hash
	
func set_dll_md5_hash(hash: String):
	_dll_md5_hash = hash
	Save()

func get_current_scene():
	return _current_scene

func set_current_scene(new_scene: Scene_enum):
	_current_scene = new_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	Load()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func Save():
	print("Saving data")
	print({
		"_dll_watch_path": _dll_watch_path,
		"_dll_md5_hash": _dll_md5_hash
	})

	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	save_file.store_var(_dll_watch_path)
	save_file.store_var(_dll_md5_hash)

func Load():
	print("Loading data")
	if not FileAccess.file_exists(save_path):
		print("Save data file not found.")
		return
	var file = FileAccess.open(save_path, FileAccess.READ)
	_dll_watch_path = file.get_var()
	_dll_md5_hash = file.get_var()

	print({
		"_dll_watch_path": _dll_watch_path,
		"_dll_md5_hash": _dll_md5_hash
	})
