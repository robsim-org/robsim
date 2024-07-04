extends Button

var dll_path : String = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	disabled = not dll_path
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_file_dialog_file_selected(path):
	print(path)
	dll_path = path
	disabled = not dll_path
	pass # Replace with function body.

func _pressed():
	print("Load " + dll_path)
	const target_dll_path = "./robsim_algo.dll"
	#var robots: Array[Node] = get_tree().get_nodes_in_group("robots_group")
	#
	#var robot_transforms: Array[Transform3D] =[] 
	#for i in robots:
		#i.Call("FreeDLL")
	
	var robot = get_node("/root/Node3D/RobotScene")
	robot.UnloadDLL()
	
	var dll_file = FileAccess.open(dll_path, FileAccess.READ)
	if dll_file == null :
		printerr('Error openning new DLL')
		printerr(dll_file.get_open_error())
		return
	var dll_content = dll_file.get_buffer(dll_file.get_length())
	
	var target_dll = FileAccess.open(target_dll_path, FileAccess.WRITE)
	if target_dll == null :
		printerr('Error openning current DLL')
		printerr(dll_file.get_open_error())
		return
	target_dll.store_buffer(dll_content)
	
	

	robot.LoadDLL()



	print("File Updated successfully!")
	
	get_tree().reload_current_scene()

