extends PanelContainer

var mouse_is_in = false

var default_color = get_theme_stylebox("panel").get("bg_color")

func _input(_event):
	var styleBox: StyleBoxFlat = get_theme_stylebox("panel").duplicate()
	if mouse_is_in:
		styleBox.set("bg_color", "#636363")
	else:
		styleBox.set("bg_color", default_color)
	add_theme_stylebox_override("panel", styleBox)
func _gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			print(event)



func _on_v_box_container_mouse_entered():
	mouse_is_in = true


func _on_v_box_container_mouse_exited():
	mouse_is_in = false
