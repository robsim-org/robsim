extends Button


var RobotScene=preload("res://Scenes/RobotScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	check_new_dll_file()
	_update_label()

func _on_file_dialog_file_selected(path):
	Global.set_dll_watch_path(path)
	_update_label()
	check_new_dll_file()

func _pressed():
	print("Loading " + Global.get_dll_watch_path())
	const target_dll_path = "./robsim_algo.dll"
	
	var robot = get_node("/root/Node3D/RobotScene")
	robot.UnloadDLL()
	
	var dll_file = FileAccess.open(Global.get_dll_watch_path(), FileAccess.READ)
	if dll_file == null :
		printerr('Error openning new DLL')
		return
	var dll_content = dll_file.get_buffer(dll_file.get_length())
	
	var target_dll = FileAccess.open(target_dll_path, FileAccess.WRITE)
	if target_dll == null :
		printerr('Error openning current DLL')
		return
	target_dll.store_buffer(dll_content)
	
	robot.LoadDLL()
	
	get_tree().reload_current_scene()
	var dll_hash = FileAccess.get_md5(Global.get_dll_watch_path())
	Global.set_dll_md5_hash(dll_hash)
	

func _update_label():
	(get_parent().get_node("PathLabel") as Label).text = Global.get_dll_watch_path()
	

func check_new_dll_file():
	if not Global.get_dll_watch_path() or Global.get_dll_watch_path() == "":
		visible = false
		return
	
	var dll_hash = FileAccess.get_md5(Global.get_dll_watch_path())

	if(dll_hash == Global.get_dll_md5_hash()):
		visible = false
		return
	visible = true

func _on_check_update_timeout():
	check_new_dll_file()
