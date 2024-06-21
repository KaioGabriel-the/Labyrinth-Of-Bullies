extends CanvasLayer
var selected : int = 0
onready var buttons = get_node("Buttons").get_children();

func _ready():
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
	if Global.world1 == true:
		Global.transitionToScene("res://scenes/World1.tscn");
	elif Global.world1 == false:
		Global.transitionToScene("res://scenes/WorldTutorial.tscn");
	
	
func _on_Exit_pressed():
	get_tree().quit();


func _on_MainMenu_pressed():
	Global.world1 = false;
	Global.transitionToScene("res://scenes/title screen.tscn");


func changeLanguage():
	if Global.languagePtBr == true:
		$Buttons/Reset.text = "Resetar";
		$Buttons/MainMenu.text = "Menu Inicial";
		$Buttons/Exit.text = "Sair";
	else: 
		$Buttons/Reset.text = "Reset";
		$Buttons/MainMenu.text = "Main Menu";
		$Buttons/Exit.text = "Exit";
		
