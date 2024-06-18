extends NinePatchRect
class_name DialogBox

onready var text := $Text
onready var timer = $Timer

var msg_queue : Array = []

func _ready():
	if Global.languagePtBr == true:
		text.bbcode_text = "Pressione Enter para Dica"
	else:
		text.bbcode_text = "Press Enter for Hint"
	show_message()

func _input(event):
	if event is InputEventKey and event.is_action_pressed("ui_accept"):
		show_message()

func add_message(_msg : Array) -> void:
	if not visible:
		show()
	msg_queue.append_array(_msg)
	
func show_message() -> void:
	if not timer.is_stopped():
		text.visible_characters = text.bbcode_text.length()
		return
	
	if msg_queue.size() == 0:
		hide()
		return
	
	text.visible_characters = 0
	var _msg : String = msg_queue.pop_front()
	text.bbcode_text = _msg
	timer.start()

func _on_Timer_timeout():
	if text.visible_characters == text.bbcode_text.length():
		timer.stop()
	text.visible_characters += 1
