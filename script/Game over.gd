extends CanvasLayer
var selected : int = 0
onready var buttons = get_node("Buttons").get_children();

func _ready():
	## Quando a cena de game over inicia, o mundo é considerado nulo
	Global.worldNode = null;
	AudioManager.player.playing = false;
	
func _process(delta):
	
	var _button = buttons[selected] as Button;
	_button.grab_focus();
	changeLanguage();
	
func _input(event):
	# Trocar opção selecionada de acordo com a direção selecionada
	var _dir = int(event.is_action_pressed("ui_down")) - int(event.is_action_pressed("ui_up"));
	selected += _dir;
	selected = clamp(selected, 0, len(buttons) - 1);
	
func _on_Reset_pressed():
	## Quando o botão reset for pressionado, a cena sera trocada para a opção desejada
	if Global.world1:
		Global.transitionToScene("res://scenes/World1.tscn");
	else:
		Global.transitionToScene("res://scenes/WorldTutorial.tscn");
	
	
func _on_Exit_pressed():
	## Quando o botão for pressionado o jogo irá sair
	get_tree().quit();


func _on_MainMenu_pressed():
	## Quando retornar para o menu o mundo 1 se torna falso novamente
	## fazendo que o tutorial seja repetido
	Global.world1 = false;
	Global.transitionToScene("res://scenes/title screen.tscn");


func changeLanguage():
	## Tradução do texto dos botões
	if Global.languagePtBr == true:
		$Buttons/Reset.text = "Resetar";
		$Buttons/MainMenu.text = "Menu Inicial";
		$Buttons/Exit.text = "Sair";
	else: 
		$Buttons/Reset.text = "Reset";
		$Buttons/MainMenu.text = "Main Menu";
		$Buttons/Exit.text = "Exit";
		
