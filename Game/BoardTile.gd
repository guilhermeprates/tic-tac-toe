extends Sprite

func _input(event):
	if event.is_action_pressed("mouse_left_click"):
		if get_rect().has_point(to_local(event.position)):
			if !visible:
				show()

