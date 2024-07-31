@tool
extends PanelContainer


@export_enum("cm", "deg") var type: String = "cm":
	set(new_type):
		type = new_type
		var unity_labels: Array[Label] = [
			get_node("HBoxContainer/X/MarginContainer/UnityLabel"), 
			get_node("HBoxContainer/Y/MarginContainer/UnityLabel"), 
			get_node("HBoxContainer/Z/MarginContainer/UnityLabel")
		]
		for l in unity_labels:
			match type:
				"cm":
					l.text = "cm"
				"deg":
					l.text = "°"	
		var spin_boxes: Array[SpinBox] = [
			get_node("HBoxContainer/X/SpinBoxX"), 
			get_node("HBoxContainer/Y/SpinBoxY"), 
			get_node("HBoxContainer/Z/SpinBoxZ")
		]
		for b in spin_boxes:
			match type:
				"cm":
					b.allow_greater = true
					b.allow_lesser = true
				"deg":
					b.allow_greater = false
					b.allow_lesser = false

var disabled = false:
	set(new_val):
		disabled = new_val
		var spin_boxes: Array[SpinBox] = [
			get_node("HBoxContainer/X/SpinBoxX"), 
			get_node("HBoxContainer/Y/SpinBoxY"), 
			get_node("HBoxContainer/Z/SpinBoxZ")
		]
		for b in spin_boxes:
			b.get_line_edit().editable = not disabled
		self.modulate.a = 1.0 if not disabled else 0.3

signal val_changed(new_val: Vector3)


var _val = Vector3(0,0,0)

func get_val():
	return _val

func set_val(new_val: Vector3, dont_emit: bool = false):
	_val = new_val
	if not dont_emit:
		val_changed.emit(new_val)


func unselect():
	var spin_boxes: Array[SpinBox] = [get_node("HBoxContainer/X/SpinBoxX"),get_node("HBoxContainer/Y/SpinBoxY"),get_node("HBoxContainer/Z/SpinBoxZ")]
	
	for box in spin_boxes:
		box.get_line_edit().release_focus()


func set_val_first_time(new_val: Vector3):
	_val = new_val
	var spin_box_x: SpinBox = get_node("HBoxContainer/X/SpinBoxX")
	var spin_box_y: SpinBox = get_node("HBoxContainer/Y/SpinBoxY")
	var spin_box_z: SpinBox = get_node("HBoxContainer/Z/SpinBoxZ")
	spin_box_x.get_line_edit().text = str(new_val.x)
	spin_box_y.get_line_edit().text = str(new_val.y)
	spin_box_z.get_line_edit().text = str(new_val.z)

	spin_box_x.set_value_no_signal(new_val.x)
	spin_box_y.set_value_no_signal(new_val.y)
	spin_box_z.set_value_no_signal(new_val.z)
	
	


func _on_spin_box_x_value_changed(value):
	set_val(Vector3(value, _val.y, _val.z))


func _on_spin_box_y_value_changed(value):
	set_val(Vector3(_val.x, value, _val.z))


func _on_spin_box_z_value_changed(value):
	set_val(Vector3(_val.x, _val.y, value))
