extends CanvasLayer

onready var dialogBox: DialogBox = get_node("DialogBox")
export (Resource) var newMessage

func add_message(_msg : Array) -> void:
	dialogBox.add_message(newMessage.msg_queue)
