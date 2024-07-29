@tool
extends VBoxContainer

@export var title: String = "Title":
	set(new_title):
		title = new_title
		var title_label = get_node("VBoxContainer/HBoxContainer/TitleLabel") as Label
		title_label.text = title

@export var child_nodes: PackedScene:
	set(new):
		print(new)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Engine.is_editor_hint():
		
		pass
		# Code to execute in editor.

	if not Engine.is_editor_hint():
		pass
		# Code to execute in game.
