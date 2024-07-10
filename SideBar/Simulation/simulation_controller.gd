extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _exit_tree():
	get_tree().paused = false


func _on_start_stop_button_pressed():
	get_tree().paused = not get_tree().paused
	print(get_tree().paused)

func _on_time_control_button_pressed():
	Engine.time_scale = 0.5
