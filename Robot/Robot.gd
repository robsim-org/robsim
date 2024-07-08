extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_speed_val(motor_idx:int, speed_val:float):
	var motor = get_node("LeftHinge/LeftWheel") as RigidBody3D if (motor_idx==0) else get_node("RightHinge/RightWheel") as RigidBody3D
	var torque = 5.0 * speed_val
	var torque_vec = Vector3(torque, 0, 0)
	var global_torque = global_transform.basis * torque_vec
	motor.apply_torque(global_torque)

func _integrate_forces(state):
	var left_wheel = get_node("LeftHinge/LeftWheel") as RigidBody3D
	var right_wheel = get_node("RightHinge/RightWheel") as RigidBody3D
	const torque = 3.0
	
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
