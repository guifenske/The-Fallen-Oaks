extends Node

func _physics_process(delta):
	if(Input.is_action_just_pressed("esc")):
		get_tree().quit()
