extends CharacterBody2D

func _physics_process(delta):
	position += transform.x * 820 * delta


func _on_area_2d_area_entered(area):
	queue_free()
