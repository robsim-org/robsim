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


signal val_changed(new_val: Vector3)


var _val: Vector3

func get_val():
	return _val

func set_val(new_val: Vector3):
	_val = new_val
	val_changed.emit(new_val)


func _on_spin_box_x_value_changed(value):
	set_val(Vector3(value, _val.y, _val.y))


func _on_spin_box_y_value_changed(value):
	set_val(Vector3(_val.x, value, _val.y))


func _on_spin_box_z_value_changed(value):
	set_val(Vector3(_val.x, _val.y, value))
