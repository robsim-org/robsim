@tool
extends JoltHingeJoint3D

class CustomData extends BaseData:
	var mass: float
	var torque: float
	var max_rpm: float
	
	var radius: float = 1.6
	var width: float = 2.1

var data = CustomData.new()

@onready var component_settings = $ComponentSettings

@export var radius: float = data.radius:
	set(new_val):
		set_radius(new_val)

@export var width: float = data.width:
	set(new_val):
		set_width(new_val)

func _ready():
	data.type = Global.BaseDataEnum.WHEEL

func set_radius(new_radius_cm: float):
	if new_radius_cm < 0.01:
		new_radius_cm = 0.01
	var coll = get_node("RigidBody3D/CollisionShape3D") as CollisionShape3D
	var wheel_mesh = get_node("RigidBody3D/wheel") as Node3D
	
	if not coll or not wheel_mesh:
		return

	data.radius = new_radius_cm
	radius = new_radius_cm
	
	coll.shape.set("radius", new_radius_cm)
	wheel_mesh.scale.y = new_radius_cm * 2
	wheel_mesh.scale.z = new_radius_cm * 2
	
func set_width(new_width_cm: float):
	if new_width_cm < 0.01:
		new_width_cm = 0.01
	var coll = get_node("RigidBody3D/CollisionShape3D") as CollisionShape3D
	var wheel_mesh = get_node("RigidBody3D/wheel") as Node3D
	var rb3d = get_node("RigidBody3D") as RigidBody3D
	
	if not coll or not wheel_mesh or not rb3d:
		return
		
	data.width = new_width_cm
	width = new_width_cm
	
	rb3d.position.z = -(new_width_cm/2)
	coll.shape.set("height", new_width_cm)
	wheel_mesh.scale.x = new_width_cm

	
