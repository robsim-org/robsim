extends Node3D


func _ready():
	Global.connect("clicked_node_changed", clicked_node_changed)

func clicked_node_changed(old_node: Node3D, new_node: Node3D):
	if new_node.get_parent() == self:
		new_node.visible = false

