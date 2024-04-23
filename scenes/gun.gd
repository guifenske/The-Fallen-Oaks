extends AnimatedSprite2D

var bulletNodeScene = preload("res://scenes/bullet.tscn")
var bullet = null
@onready var main = get_tree().get_root()

func instantiate_bullet():
		bullet = bulletNodeScene.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
		bullet.position = position
		bullet.look_at(get_global_mouse_position())
		bullet.position += transform.x * 2
		main.add_child(bullet)

func _on_animation_looped():
	if(animation == "idle"): return
	instantiate_bullet()
