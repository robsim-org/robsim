extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var motor0_speed_val:float = 0.0
var motor1_speed_val:float = 0.0


func set_speed_val(motor_idx:int, speed_val:float):
	match motor_idx:
		0:
			motor0_speed_val = speed_val
		1: 
			motor1_speed_val = speed_val

func _manual_controll():
	var torque = 3.0
	var left_wheel = get_node("LeftHinge/LeftWheel") as RigidBody3D
	var right_wheel = get_node("RightHinge/RightWheel") as RigidBody3D
	if Input.is_action_pressed("left_up"):
		var torque_vec = Vector3(torque, 0, 0)
		var global_torque = global_transform.basis * torque_vec
		left_wheel.apply_torque(global_torque)
	if Input.is_action_pressed("left_down"):
		var torque_vec = Vector3(-torque, 0, 0)
		var global_torque = global_transform.basis * torque_vec
		left_wheel.apply_torque(global_torque)
	if Input.is_action_pressed("right_up"):
		var torque_vec = Vector3(torque, 0, 0)
		var global_torque = global_transform.basis * torque_vec	
		right_wheel.apply_torque(global_torque)
	if Input.is_action_pressed("right_down"):
		var torque_vec = Vector3(-torque, 0, 0)
		var global_torque = global_transform.basis * torque_vec
		right_wheel.apply_torque(global_torque)
func _integrate_forces(state):
	var left_wheel = get_node("LeftHinge/LeftWheel") as RigidBody3D
	var right_wheel = get_node("RightHinge/RightWheel") as RigidBody3D
	var torque = 5.0
	left_wheel.apply_torque(global_transform.basis * Vector3(torque * motor0_speed_val, 0, 0))
	right_wheel.apply_torque(global_transform.basis * Vector3(torque * motor1_speed_val, 0, 0))
	
	_manual_controll()

