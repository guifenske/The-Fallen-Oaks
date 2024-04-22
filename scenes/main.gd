extends Node

func instantiate_gun(gunNodeScene : PackedScene):
	gun = gunNodeScene.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	gun.position = position
	main.add_child(gun)
	
func instantiate_bullet():
		bullet = bulletNodeScene.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
		bullet.position = gun.position
		bullet.look_at(get_global_mouse_position())
		main.add_child(bullet)
