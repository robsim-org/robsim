extends SubViewport

var simulation_node_3d = preload("res://Scenes/Simulation/simulation.tscn")
var robot_editor_node_3d = preload("res://Scenes/RobotEditor/robot_editor.tscn")
var scene_editor_node_3d = preload("res://Scenes/SceneEditor/scene_editor.tscn")

func _ready():
	Global.connect("scene_changed", scene_changed)

func scene_changed(old_value: Global.SceneEnum, new_value: Global.SceneEnum):
	_update_3d_node(new_value)

func _update_3d_node(new_value: Global.SceneEnum):
	get_node("Node3D").free()
	match new_value:
		Global.SceneEnum.SIMULATION:
			add_child(simulation_node_3d.instantiate())
		Global.SceneEnum.ROBOT_EDITOR:
			add_child(robot_editor_node_3d.instantiate())		
		Global.SceneEnum.SCENE_EDITOR:
			add_child(scene_editor_node_3d.instantiate())	
	
