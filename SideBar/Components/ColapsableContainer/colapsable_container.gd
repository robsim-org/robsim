@tool
extends VBoxContainer

@export var title: String = "Title":
	set(new_title):
		title = new_title
		var title_label = get_node("VBoxContainer/HBoxContainer/TitleLabel") as Label
		title_label.text = title
