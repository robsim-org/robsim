extends Node3D

func _ready():
	rotate(Vector3(1,0,0), randf_range(0,360))
	rotate(Vector3(0,1,0), randf_range(0,360))
	rotate(Vector3(0,0,1), randf_range(0,360))

func _process(delta):
	rotate(Vector3(1,0,0), 0.3 * delta)
	rotate(Vector3(0,1,0), 0.3 * delta)
	rotate(Vector3(0,0,1), 0.3 * delta)
