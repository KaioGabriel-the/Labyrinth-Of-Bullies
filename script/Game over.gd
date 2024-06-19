extends CanvasLayer
var selected : int = 0

func _process(delta):
	var _buttons = $Buttons.get_children()
	
	var _dir = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))
	selected += _dir
	selected = clamp(selected, 0, len(_buttons) - 1)
	
	var _button = _buttons[selected] as Button
	_button.grab_focus()
	changeLanguage()
	
	
	
func _on_Reset_pressed():
	if Global.world1 == true:
		Global.transitionToScene("res://scenes/World1.tscn")
	elif Global.world1 == false:
		Global.transitionToScene("res://scenes/WorldTutorial.tscn")
	
	
func _on_Exit_pressed():
	get_tree().quit()


func _on_MainMenu_pressed():
	Global.world1 = false
	Global.transitionToScene("res://scenes/title screen.tscn")


func changeLanguage():
	if Global.languagePtBr == true:
		$Buttons/Reset.text = "Resetar"
		$Buttons/MainMenu.text = "Menu Inicial"
		$Buttons/Exit.text = "Sair"
	else: 
		$Buttons/Reset.text = "Reset"
		$Buttons/MainMenu.text = "Main Menu"
		$Buttons/Exit.text = "Exit"
		
