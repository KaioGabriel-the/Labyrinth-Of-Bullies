extends CanvasLayer

var selected : int = 0
var paused : bool = false
onready var buttons = $Buttons.get_children();

func _ready():
	## Tela de pause começa invisivel
	visible = false

func _process(delta):
	## Se não tiver botão nada acontece
	if buttons.size() == 0:
		return
	## Pega o foco do botão selecionado
	var _button = buttons[selected] as Button
	_button.grab_focus()
	changeLanguage()
	
func _input(event):
	# Trocar opção selecionada de acordo com a direção selecionada
	var _dir = int(event.is_action_pressed("ui_down")) - int(event.is_action_pressed("ui_up"));
	selected += _dir;
	selected = clamp(selected, 0, len(buttons) - 1);
	
	## Quando ui_cancel for apertado, a tela de pausa irá aparecer
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func changeLanguage():
	## Idioma dos texto dos botões dependendo da linguagem
	if Global.languagePtBr == true:
		$Buttons/Resume.text = "Retornar"
		$Buttons/Main_Menu.text = "Menu Inicial"
		$Label.text = "Pausado"
	else:
		$Buttons/Resume.text = "Resume"
		$Buttons/Main_Menu.text = "Main Menu"
		$Label.text = "Paused"


func toggle_pause():
	## Se for falso, ao pressionar fica verdadeira, assim funciona corretamente
	paused = !paused
	## O jogo é pausado se for true, e funciona normalmente se for true
	get_tree().paused = paused
	## A visibilidade é dependente do mesmo false e true
	visible = paused


func _on_Resume_pressed():
	## Se a tecla de retornar for pressionada, faz a mesma função de "ui_cancel"
	toggle_pause();

func _on_Main_Menu_pressed():
	## Se for pa
	get_tree().paused = false
	Global.transitionToScene("res://scenes/title screen.tscn");
