extends Node3D

@export var parent_root:Node3D

var highlighted_material = preload("res://Robot/Components/component_highlight_material.tres")

func _ready():
	Global.connect("clicked_node_changed", clicked_node_changed)

func clicked_node_changed(old_node: Node3D, new_node: Node3D):
	if new_node and new_node == parent_root:
		set_material_overlay_recursive(self, highlighted_material)
	else:
		set_material_overlay_recursive(self, null)


func set_material_overlay_recursive(my_node, new_material_overlay):
	if my_node is MeshInstance3D:
		my_node.material_overlay = new_material_overlay
	var childs = my_node.get_children()
	for c in childs:
		set_material_overlay_recursive(c, new_material_overlay)
