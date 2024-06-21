extends CanvasLayer

var selected : int = 0
var paused : bool = false
onready var buttons = $Buttons.get_children();

func _ready():
	visible = false

func _process(delta):
	if buttons.size() == 0:
		return

	var _button = buttons[selected] as Button
	_button.grab_focus()
	changeLanguage()
	
func _input(event):
	# Trocar opção selecionada de acordo com a direção selecionada
	var _dir = int(event.is_action_pressed("ui_down")) - int(event.is_action_pressed("ui_up"));
	selected += _dir;
	selected = clamp(selected, 0, len(buttons) - 1);
	
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func changeLanguage():
	if Global.languagePtBr == true:
		$Buttons/Resume.text = "Retornar"
		$Buttons/Main_Menu.text = "Menu Inicial"
		$Label.text = "Pausado"
	else:
		$Buttons/Resume.text = "Resume"
		$Buttons/Main_Menu.text = "Main Menu"
		$Label.text = "Paused"


func toggle_pause():
	paused = !paused
	get_tree().paused = paused
	visible = paused


func _on_Resume_pressed():
	toggle_pause();

func _on_Main_Menu_pressed():
	get_tree().paused = false
	Global.transitionToScene("res://scenes/title screen.tscn");
