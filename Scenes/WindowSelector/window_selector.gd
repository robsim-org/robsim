extends PanelContainer

@export var simulation_button: NodePath
@export var robot_editor_button: NodePath
@export var scene_editor_button: NodePath

func _ready():
	Global.connect("scene_changed", scene_changed)

func scene_changed(old_value: Global.SceneEnum, new_value: Global.SceneEnum):
	_update_buttons_appearence(new_value)

func _update_buttons_appearence(new_scene: Global.SceneEnum):
	(get_node(simulation_button) as Button).disabled = (new_scene == Global.SceneEnum.SIMULATION)
	(get_node(robot_editor_button) as Button).disabled = (new_scene == Global.SceneEnum.ROBOT_EDITOR)
	(get_node(scene_editor_button) as Button).disabled = (new_scene == Global.SceneEnum.SCENE_EDITOR)

func _on_simulation_button_pressed():
	Global.set_current_scene(Global.SceneEnum.SIMULATION)

func _on_robot_editor_button_pressed():
	Global.set_current_scene(Global.SceneEnum.ROBOT_EDITOR)

func _on_scene_editor_button_pressed():
	Global.set_current_scene(Global.SceneEnum.SCENE_EDITOR)
