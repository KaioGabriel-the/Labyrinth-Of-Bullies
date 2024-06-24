extends NinePatchRect


onready var text := $Text
onready var timer = $Timer

var msg_queue : Array = []

func _ready():
	## Enquanto o mundo 1 não tiver sido alcançado, a linguagem escolhida não esta definida
	if Global.world1 == false:
		if Global.languagePtBr:
			## Altera o texto de acordo com a linguagem selecionada
			text.bbcode_text = "Pressione Enter para Dica"
		else:
			text.bbcode_text = "Press Enter for Hint"
		## Mostra o texto no momento que o tutorial começa
		show_message()

func _process(delta):
	## No momento que o mundo um for alcançado, o texto some da tela
	## Sendo disponivel apenas no tutorial
	if Global.world1 == true:
		hide()

func _input(event):
	## Quando enter for apertado no tutorial, o texto novo é apresentado
	if Global.world1 == false and event.is_action_pressed("ui_accept") and Global.inputCooldown <= 0:
		show_message()

func add_message(_msg : Array) -> void:
	## A função é chamada em outras partes do código
	if not visible:
		show()
	## Adiciona a mensagem dentro do array
	msg_queue.append_array(_msg)

func show_message() -> void:
	## Se o mundo 1 for verdaeiro, tudo sobre a dialogBox é ignorado
	if Global.world1:
		return

	if not timer.is_stopped():
		## Se o texto não tiver sido completado, o texto é completado sozinho
		text.visible_characters = text.bbcode_text.length()
		return
	
	## Se o texto tiver acabado, ele some da tela
	if msg_queue.size() == 0:
		hide()
		return

	text.visible_characters = 0
	var _msg : String = msg_queue.pop_front()
	text.bbcode_text = _msg
	timer.start()

func _on_Timer_timeout():
	## Mostra caractere por caractere durante o tempo desejado, até a mensagem ser completada
	if text.visible_characters == text.bbcode_text.length():
		timer.stop()
	text.visible_characters += 1

