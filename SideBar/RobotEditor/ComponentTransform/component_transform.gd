extends PanelContainer

@export var position_editor: Node
@export var rotation_editor: Node

var selected_node: Node3D = null


func _ready():
	Global.connect("clicked_node_changed", clicked_node_changed)
	self.visible = false

func clicked_node_changed(old_node: Node3D, new_node: Node3D):
	selected_node = new_node
	if(new_node):
		self.visible = true
		position_editor.set_val(selected_node.get_parent().position, true)
		rotation_editor.set_val(selected_node.get_parent().rotation, true)
		
		position_editor.disabled = new_node.get_parent().is_root
		rotation_editor.disabled = new_node.get_parent().is_root
		


	else:
		self.visible = false





func _on_rotation_editor_val_changed(new_val):
	if selected_node:
		selected_node.get_parent().rotation_degrees = new_val



func _on_position_editor_val_changed(new_val):
	if selected_node:
		selected_node.get_parent().position = new_val
