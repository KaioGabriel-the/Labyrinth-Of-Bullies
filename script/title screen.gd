extends CanvasLayer

var selected = 0;
onready var buttons = get_node("Buttons").get_children();

func _ready():
	Global.worldNode = null;
	AudioManager.playMusic("title");
	
func _process(delta):
	var _button = buttons[selected] as Button;
	_button.grab_focus();
	changeLanguage();
	
func _input(event):
	# Trocar opção selecionada de acordo com a direção selecionada
	var _dir = int(event.is_action_pressed("ui_down")) - int(event.is_action_pressed("ui_up"));
	selected += _dir;
	selected = clamp(selected, 0, len(buttons) - 1);
	
func _on_START_pressed():
	print("Start foi pressionado");
	Global.transitionToScene("res://scenes/WorldTutorial.tscn");

func _on_EXIT_pressed():
	get_tree().quit();

func _on_Portugues_pressed():
	Global.transitionToScene("res://scenes/Language.tscn");

func changeLanguage():
	if Global.languagePtBr == true:
		$Buttons/START.text = "Iniciar";
		$Buttons/LANGUAGE.text = "Linguagem";
		$Buttons/EXIT.text = "Sair";
	else:
		$Buttons/START.text = "Start";
		$Buttons/LANGUAGE.text = "Language";
		$Buttons/EXIT.text = "Exit";
		
		
