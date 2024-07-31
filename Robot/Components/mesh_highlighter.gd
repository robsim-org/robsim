extends MeshInstance3D

@export var parent_rigid_body:RigidBody3D

var highlighted_material = preload("res://Robot/Components/component_highlight_material.tres")

func _ready():
	Global.connect("clicked_node_changed", clicked_node_changed)

func clicked_node_changed(old_node: Node3D, new_node: Node3D):
	if new_node and new_node == parent_rigid_body:
		self.material_overlay = highlighted_material
	else:
		self.material_overlay = null

