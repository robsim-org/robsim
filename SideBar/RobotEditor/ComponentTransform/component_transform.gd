extends PanelContainer

@export var position_editor: Node
@export var rotation_editor: Node

var selected_node: Node3D = null


func _ready():
	Global.connect("clicked_node_changed", clicked_node_changed)
	self.visible = false

func clicked_node_changed(old_node: Node3D, new_node: Node3D):
	selected_node = new_node
	position_editor.unselect()
	rotation_editor.unselect()
	if(new_node):
		self.visible = true

		position_editor.set_val_first_time(new_node.position)
		rotation_editor.set_val_first_time(new_node.rotation_degrees)
		
		if "is_root" in new_node:
			position_editor.disabled = true
			rotation_editor.disabled = true
		else:
			position_editor.disabled = false
			rotation_editor.disabled = false
	else:
		self.visible = false






func _on_rotation_editor_val_changed(new_val):
	if selected_node:
		selected_node.rotation_degrees = new_val



func _on_position_editor_val_changed(new_val):
	if selected_node:
		selected_node.position = new_val
