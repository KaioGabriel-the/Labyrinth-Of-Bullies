extends CanvasLayer

export var selected: int = 0;

func _ready():
	pass

func _process(delta):
	var _buttons = $Buttons.get_children()
	
	if Input.is_action_just_pressed("ui_up"):
		selected = 0;
		
	if Input.is_action_just_pressed("ui_down"):
		selected = len(_buttons) - 1;
	
	var _dir = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))
	print("dir: ", _dir);
	selected += _dir
	selected = clamp(selected, 0, len(_buttons) - 1)
	
	var _button = _buttons[selected] as Button
	print(_button)
	_button.call_deferred("grab_focus");
	
	print(selected)

func _on_LanguageBR_pressed():
	Global.languagePtBr = true


func _on_LanguageEUA_pressed():
	Global.languagePtBr = false


func _on_Back_pressed():
	Global.transitionToScene("res://scenes/title screen.tscn")
