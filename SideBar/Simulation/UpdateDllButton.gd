extends Button

@export var path_label: Label
const target_dll_path = "./robsim_algo.dll"

# Called when the node enters the scene tree for the first time.
func _ready():
	_check_new_dll_file()
	_update_label()
	
func _pressed():
	print("Loading " + Global.get_dll_watch_path())

	var robots = get_tree().get_nodes_in_group("robots_group")
	
	for robot in robots:
		robot.UnloadDLL()
		
	var dll_file = FileAccess.open(Global.get_dll_watch_path(), FileAccess.READ)
	if dll_file == null:
		printerr('Error openning new DLL')
		return
	var dll_content = dll_file.get_buffer(dll_file.get_length())
	
	var target_dll = FileAccess.open(target_dll_path, FileAccess.WRITE)
	if target_dll == null:
		printerr('Error openning current DLL')
		return
	target_dll.store_buffer(dll_content)
	
	for robot in robots:
		robot.LoadDLL()
	
	get_tree().reload_current_scene()
	var dll_hash = FileAccess.get_md5(Global.get_dll_watch_path())
	Global.set_dll_md5_hash(dll_hash)

func _on_check_update_timer_timeout():
	_check_new_dll_file()

func _on_file_dialog_file_selected(path):
	Global.set_dll_watch_path(path)
	_update_label()
	_check_new_dll_file()

func _update_label():
	path_label.text = Global.get_dll_watch_path()
	
func _check_new_dll_file():
	if not Global.get_dll_watch_path() or Global.get_dll_watch_path() == "":
		disabled = true
		return
	
	var dll_hash = FileAccess.get_md5(Global.get_dll_watch_path())

	if (dll_hash == Global.get_dll_md5_hash()):
		disabled = true
		return
	disabled = false
