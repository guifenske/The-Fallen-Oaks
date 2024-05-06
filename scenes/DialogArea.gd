extends Area2D

@export var text: String
var is_player_colliding = false

func _input(event):
	if(is_player_colliding && event.is_action_pressed("t")):
		SignalBus.emit_signal("display_dialog", text)
		
func _on_area_entered(area):
	SignalBus.emit_signal("display_dialog", "Press 't' to read the scripture")
	is_player_colliding = true


func _on_area_exited(area):
	is_player_colliding = false
	SignalBus.emit_signal("clear_dialog")
