extends Camera3D

@export_range(0, 10, 0.01) var sensitivity: float = 3
@export_range(0, 1000, 0.1) var default_velocity: float = 5
@export_range(0, 10, 0.01) var speed_scale: float = 1.17
@export_range(1, 100, 0.1) var boost_speed_multiplier: float = 3.0
@export var max_speed: float = 1000
@export var min_speed: float = 0.2

@onready var _velocity = default_velocity


func _input(event):
	if not current:
		return

	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotation.y -= event.relative.x / 1000 * sensitivity
			rotation.x -= event.relative.y / 1000 * sensitivity
			rotation.x = clamp(rotation.x, PI / - 2, PI / 2)
	
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_RIGHT:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if event.pressed else Input.MOUSE_MODE_VISIBLE)
			MOUSE_BUTTON_WHEEL_UP: # increase fly velocity
				_velocity = clamp(_velocity * speed_scale, min_speed, max_speed)
			MOUSE_BUTTON_WHEEL_DOWN: # decrease fly velocity
				_velocity = clamp(_velocity / speed_scale, min_speed, max_speed)
			MOUSE_BUTTON_LEFT:
				_shoot_ray()

func _shoot_ray():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_len = 900000
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * ray_len
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var ray_result = space.intersect_ray(ray_query)
	
	if not ray_result.is_empty():
		var pth = ray_result.collider.get_path()
		var clicked_node = get_node(pth)
		if clicked_node.is_in_group("component"):
			Global.set_clicked_node(clicked_node.get_parent())
			return
	Global.set_clicked_node(null)
	

func _process(delta):
	delta = delta/Engine.time_scale
	if not current:
		return
		
	var direction = Vector3(
		float(Input.is_physical_key_pressed(KEY_D)) - float(Input.is_physical_key_pressed(KEY_A)),
		float(Input.is_physical_key_pressed(KEY_E)) - float(Input.is_physical_key_pressed(KEY_Q)),
		float(Input.is_physical_key_pressed(KEY_S)) - float(Input.is_physical_key_pressed(KEY_W))
	).normalized()
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		if Input.is_physical_key_pressed(KEY_SHIFT):
			translate(direction * _velocity * delta * boost_speed_multiplier)
		else:
			translate(direction * _velocity * delta)
