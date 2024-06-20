extends CanvasLayer

var selected : int = 0
var paused : bool = false

func _ready():
	visible = false

func _process(delta):
	var _buttons = $Buttons.get_children()

	if _buttons.size() == 0:
		return

	var _dir = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))
	selected += _dir
	selected = clamp(selected, 0, len(_buttons) - 1)

	var _button = _buttons[selected] as Button
	_button.grab_focus()
	changeLanguage()

func changeLanguage():
	if Global.languagePtBr == true:
		$Buttons/Resume.text = "Retornar"
		$Buttons/Main_Menu.text = "Menu Inicial"
		$Label.text = "Pausado"
	else:
		$Buttons/Resume.text = "Resume"
		$Buttons/Main_Menu.text = "Main Menu"
		$Label.text = "Paused"

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	paused = !paused
	get_tree().paused = paused
	visible = paused


func _on_Resume_pressed():
	toggle_pause();

func _on_Main_Menu_pressed():
	get_tree().paused = false
	Global.transitionToScene("res://scenes/title screen.tscn");
