extends CharacterBody2D

func _physics_process(delta):
	position += transform.x * 820 * delta
