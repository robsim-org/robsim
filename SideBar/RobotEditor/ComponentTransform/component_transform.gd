extends PanelContainer


func _ready():
	Global.connect("clicked_node_changed", clicked_node_changed)

func clicked_node_changed(old_node: Node3D, new_node: Node3D):
	print(new_node)

