extends CharacterBody2D

@onready var timer = $Timer
@onready var particles = $BreakParticle

func _physics_process(delta):
	position += transform.x * 1750 * delta


func _on_area_2d_area_entered(area):
	queue_free()


func _on_timer_timeout():
	queue_free()
