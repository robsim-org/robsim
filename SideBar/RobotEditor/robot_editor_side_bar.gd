extends Control


func _ready():
	Global.connect("clicked_node_changed", clicked_node_changed)


func clicked_node_changed(old_node: Node3D, new_node: Node3D):
	# Reseting the component settings to the old parent
	if old_node:
		if old_node.get("component_settings"):
			var comp_settings: PanelContainer = old_node.get("component_settings")
			comp_settings.reparent(old_node)
			comp_settings.visible = false
	
	if(new_node):
		if new_node.get("component_settings"):
			var comp_settings: PanelContainer = new_node.get("component_settings")
			var vbox_container = get_node("VBoxContainer")
			comp_settings.reparent(vbox_container,false)
			comp_settings.visible = true



