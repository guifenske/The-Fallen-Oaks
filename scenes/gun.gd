extends AnimatedSprite2D

@onready var playerNode = get_tree().get_root().get_node("player").get_child(0)

func _on_animation_looped():
	playerNode.instantiate_bullet()
