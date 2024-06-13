extends CanvasLayer

var selected = 0;

func _ready():
	pass
	
func _process(delta):
	var _buttons = $Buttons.get_children();
	
	var _dir = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"));
	selected += _dir;
	selected = clamp(selected, 0, len(_buttons) - 1);
	
	var _button = _buttons[selected] as Button;
	_button.grab_focus();
	
func _on_START_pressed():
	get_tree().change_scene("res://scenes/World1.tscn")


func _on_EXIT_pressed():
	get_tree().quit()
