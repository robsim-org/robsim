extends ScrollContainer


var simulation_side_bar = preload("res://SideBar/Simulation/simulation_side_bar.tscn")
var robot_editor_side_bar = preload("res://SideBar/RobotEditor/robot_editor_side_bar.tscn")
var scene_editor_side_bar = preload("res://SideBar/Simulation/simulation_side_bar.tscn")

func _ready():
	Global.connect("scene_changed", scene_changed)

func scene_changed(old_value: Global.SceneEnum, new_value: Global.SceneEnum):
	_update_3d_node(new_value)

func _update_3d_node(new_value: Global.SceneEnum):
	get_node("Node2D").free()
	match new_value:
		Global.SceneEnum.SIMULATION:
			add_child(simulation_side_bar.instantiate())
		Global.SceneEnum.ROBOT_EDITOR:
			add_child(robot_editor_side_bar.instantiate())		
		Global.SceneEnum.SCENE_EDITOR:
			add_child(scene_editor_side_bar.instantiate())	
	
