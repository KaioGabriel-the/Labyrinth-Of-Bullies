extends CanvasLayer
onready var dialog_box = $DialogBox
export (Resource) var newMessage

func _ready():
	add_text(newMessage)
	
func add_text(_msg) -> void:
	dialog_box.add_message(_msg.msg_queue)

func _process(delta):
	if Input.is_action_just_pressed("ui_home"):
		var _dialog = [
			"sexo é bom",
			"ops, engasgei",
			"rsrsrsrs"
		];
		dialog_box.add_message(_dialog);
