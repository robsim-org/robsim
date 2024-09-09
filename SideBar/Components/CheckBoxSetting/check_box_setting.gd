@tool
extends HBoxContainer

@export var label: String = "My Label":
	set(new_val):
		label = new_val
		(get_node("Label") as Label).text = label

@export var default_value: bool = false:
	set(new_val):
		default_value = new_val
		(get_node("CheckBox")as CheckBox).set("button_pressed", new_val)
		
signal value_changed(new_val: bool, my_label: String)

func _on_check_box_toggled(toggled_on):
	value_changed.emit(toggled_on, label)
