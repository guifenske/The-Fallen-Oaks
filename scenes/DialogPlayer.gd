extends CanvasLayer
@onready var textNode = %Text
var is_writing_text = false
var string : String
var index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("display_dialog", Callable(self, "display_dialog"))
	SignalBus.connect("clear_dialog", Callable(self, "clear_dialog"))
	
func display_dialog(text):
	if(is_writing_text): return
	textNode.text = ""
	string = text
	is_writing_text = true
	%Timer.start()
	
func clear_dialog():
	%Timer.stop()
	textNode.text = ""
	index = 0
	is_writing_text = false


func _on_timer_timeout():
	textNode.text += string[index]
	index+=1
	if(index == string.length()):
		%Timer.stop()
		is_writing_text = false
		index = 0
	
