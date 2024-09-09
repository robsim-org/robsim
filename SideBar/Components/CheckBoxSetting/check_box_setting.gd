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
		
