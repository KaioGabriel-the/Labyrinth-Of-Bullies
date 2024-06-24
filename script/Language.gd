extends CanvasLayer

onready var buttons = $Buttons.get_children();
export var selected: int = 0;

func _ready():
	# Conceder foco ao botão correspondente a linguagem selecionada
	selected = 0 if Global.languagePtBr else 1;

func _process(delta):
	## Chama o foco para o botão selecionado, dentro do array buttons
	var _button = buttons[selected] as Button;
	_button.call_deferred("grab_focus");
	## Troca o idioma dos texto no exato momento que se aperta
	changeLanguage();
	
func _input(event):
	## Impede troca infinita de botão, com o cooldown, vai de botão em botão
	if Global.inputCooldown <= 0:
		if event.is_action_pressed("ui_up"):
			selected = 0;
			
		if event.is_action_pressed("ui_down"):
			selected = len(buttons) - 1;
		
		# Trocar opção selecionada de acordo com a direção selecionada
		var _dir = int(event.is_action_pressed("ui_right")) - int(event.is_action_pressed("ui_left"));
		selected += _dir;
		selected = clamp(selected, 0, len(buttons) - 1);

## As duas funções trocam a linguagem ao pressionar o botão da lingua desejada
func _on_LanguageBR_pressed():
	Global.languagePtBr = true;

func _on_LanguageEUA_pressed():
	Global.languagePtBr = false;

# A função faz a retornar para a tela de titulo
func _on_Back_pressed():
	Global.transitionToScene("res://scenes/title screen.tscn");

## Texto dos botões dependendo do idioma escolhido
func changeLanguage():
	if Global.languagePtBr:
		$Buttons/Back.text = "Voltar";
		$Label.text = "Selecione a Linguagem";
		$Label/Label.text = "Selecione a Linguagem";
	else:
		$Buttons/Back.text = "Back";
		$Label.text = "Select Language";
		$Label/Label.text = "Select Language";
