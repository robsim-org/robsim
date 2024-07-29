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
		position_editor.set_val(selected_node.position)
		rotation_editor.set_val(selected_node.rotation)
		self.visible = true
	else:
		self.visible = false


func _on_transform_component_transform_changed(new_transform):
	pass # Replace with function body.




func _on_rotation_editor_val_changed(new_val):
	if selected_node:
		selected_node.rotation_degrees = new_val



func _on_position_editor_val_changed(new_val):
	if selected_node:
		selected_node.position = new_val
