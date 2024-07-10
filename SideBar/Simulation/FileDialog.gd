extends FileDialog

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_current_file(Global.get_dll_watch_path())
	
	visible = false
	pass # Replace with function body.
