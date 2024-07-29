extends Node3D

@export var mesh: MeshInstance3D

# If true the component will not be movable while editing
@export var is_root: bool = false

var highlighted_material = preload("res://Robot/Components/component_highlight_material.tres")

func _ready():
	Global.connect("clicked_node_changed", clicked_node_changed)

func clicked_node_changed(old_node: Node3D, new_node: Node3D):
	
	if new_node and new_node.get_parent() == self:
		mesh.material_overlay = highlighted_material
	else:
		mesh.material_overlay = null

