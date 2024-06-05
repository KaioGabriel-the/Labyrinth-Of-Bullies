extends Node2D

export (Resource) var newMsg

func _ready():
	DialogBox.add_message(newMsg.msg_queue)

