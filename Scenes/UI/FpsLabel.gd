extends Label

func _process(delta: float) -> void:
	set_text("FPS " + ("%.02f" %Engine.get_frames_per_second()))
