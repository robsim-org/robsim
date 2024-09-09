extends Node3D

var selected_node: Node3D = null

func _ready():
	_freeze_child_recurs(self)
	Global.connect("clicked_node_changed", clicked_node_changed)

func _freeze_child_recurs(parent_node: Node):
	if not parent_node.get_child_count():
		return
	for child in parent_node.get_children():
		if child is RigidBody3D:
			child.freeze = true
		_freeze_child_recurs(child)

func _input(event):
	if event.is_action_pressed("delete"):
		if selected_node:
			if not "is_root" in selected_node:
				selected_node.queue_free()

func add_component(component_type: Global.BaseDataEnum, component_resource: Resource):
	match component_type:
		Global.BaseDataEnum.WHEEL:
			var wheel_handler: Node3D = get_node("ESP32/WheelHandler")
			var scene = load(component_resource.resource_path)
			var instance:Node3D = scene.instantiate()
			_freeze_child_recurs(instance)
			instance.position = Vector3()
			wheel_handler.add_child(instance)
			print(instance)


func clicked_node_changed(old_node: Node3D, new_node: Node3D):
	selected_node = new_node


