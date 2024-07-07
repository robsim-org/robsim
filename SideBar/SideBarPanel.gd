extends PanelContainer

@export var simulation_side_bar: PackedScene
@export var robot_editor_side_bar: PackedScene
@export var scene_editor_side_bar: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	match Global.get_current_scene():
		Global.Scene_enum.SIMULATION:
			add_child(simulation_side_bar.instantiate())
		_:
			printerr("Invalid Scene")
			
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
