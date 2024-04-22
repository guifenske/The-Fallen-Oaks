extends CharacterBody2D


const SPEED = 500.0

func _physics_process(delta):
	position += transform.x * 300 * delta
	
