extends CanvasLayer

onready var dialog_box = $DialogBox
var newMessage = []

func _ready():
	if Global.languagePtBr:
		newMessage = [
			"Arraste o potenciômetro para abrir as portas"
		]
	else:
		newMessage = [
			"Drag the Potentiometer to Open The Door"
		]
	add_text(newMessage)

func add_text(_msg) -> void:
	dialog_box.add_message(_msg)

func _process(delta):
	if Input.is_action_just_pressed("ui_home"):
		var _dialog = [
			"Por enquanto nada"
		]
		dialog_box.add_message(_dialog)
