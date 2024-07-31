extends Node3D

func _process(delta):
	rotate(Vector3(1,0,0), 0.5 * delta)
	rotate(Vector3(0,1,0), 0.3 * delta)
	rotate(Vector3(0,0,1), 0.2 * delta)
