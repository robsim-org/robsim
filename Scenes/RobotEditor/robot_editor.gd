extends Node3D

func _ready():
	_freeze_child_recurs(self)

func _freeze_child_recurs(parent_node: Node):
	if not parent_node.get_child_count():
		return
	for child in parent_node.get_children():
		if child is RigidBody3D:
			child.freeze = true
		_freeze_child_recurs(child)
