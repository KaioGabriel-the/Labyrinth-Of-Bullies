extends CanvasLayer

## Faz o dialogBox iniciar junto com o jogo
onready var dialog_box = $DialogBox
var newMessage = []

func _ready():
	## Mensagem inicial do balão do tutorial, dependendo do idioma
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
	## Adiciona o texto dentro do array na DialogBox
	dialog_box.add_message(_msg)

