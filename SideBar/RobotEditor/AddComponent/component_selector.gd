extends PanelContainer

@export var component_resource: Resource

@export var component_type: Global.BaseDataEnum



var mouse_is_in = false

var clicked_do_once = false

var default_color = get_theme_stylebox("panel").get("bg_color")

var component_name: String

var last_click_tick_ms = Time.get_ticks_msec()

func pressed():
	var robot_editor = get_tree().get_first_node_in_group("robot_editor_node_3d")
	robot_editor.add_component(component_type, component_resource)
	
func _freeze_child_recurs(parent_node: Node):
	if not parent_node.get_child_count():
		return
	for child in parent_node.get_children():
		if child is RigidBody3D:
			child.freeze = true
		_freeze_child_recurs(child)
		
func _ready():
	var rotator_node = get_node("VBoxContainer/MarginContainer/PanelContainer/SubViewportContainer/SubViewport/Node3D/ComponentNode/Rotator") as Node3D
	var scene = load(component_resource.resource_path)
	var instance = scene.instantiate()
	_freeze_child_recurs(instance)
	rotator_node.add_child(instance)
	
	component_name = Global.BaseDataEnum.keys()[component_type]
	(get_node("VBoxContainer/MarginContainer2/Label") as Label).text = component_name.capitalize()

func _input(event):
	var styleBox: StyleBoxFlat = get_theme_stylebox("panel").duplicate()
	if mouse_is_in:
		if event is InputEventMouseButton:
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					styleBox.set("bg_color", "#1E1E1E")
					if not clicked_do_once:
						if Time.get_ticks_msec() - last_click_tick_ms > 200:
							clicked_do_once = true
							pressed()
							last_click_tick_ms = Time.get_ticks_msec()
				
		else:
			styleBox.set("bg_color", "#636363")
			clicked_do_once = false
	else:
		styleBox.set("bg_color", default_color)
		clicked_do_once = false
	add_theme_stylebox_override("panel", styleBox)
	


func _on_v_box_container_mouse_entered():
	mouse_is_in = true


func _on_v_box_container_mouse_exited():
	mouse_is_in = false
