extends AnimationPlayer


func _on_animation_finished(anim_name):
	if(anim_name == "fade_out"):
		get_tree().change_scene_to_file("res://scenes/main.tscn");
