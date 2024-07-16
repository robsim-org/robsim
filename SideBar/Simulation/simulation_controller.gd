extends PanelContainer


const _paused_time_scale:float = 0.0000001

var _unpaused_time_scale: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	if not Global.get_auto_start_on_load():
		_pause()
	var auto_start_button = get_node("VBoxContainer/MarginContainer/VBoxContainer/AutoStartOnLoad") as CheckBox
	auto_start_button.set_pressed_no_signal(Global.get_auto_start_on_load())
	
func _exit_tree():
	_unpause_to_realtime()


func _pause():
	Engine.time_scale = _paused_time_scale

func _unpause_to_realtime():
	Engine.time_scale = 1.0

func _unpause_to_time_scale():
	Engine.time_scale = _unpaused_time_scale

func _on_start_stop_button_pressed():
	if Engine.time_scale == _paused_time_scale:
		_unpause_to_time_scale()
	else:
		_pause()

func _on_time_control_button_pressed():
	_unpaused_time_scale = 0.5
	_unpause_to_time_scale()


func _on_auto_start_on_load_toggled(toggled_on):
	Global.set_auto_start_on_load(toggled_on)


func _on_reset_button_pressed():
	get_tree().reload_current_scene()
