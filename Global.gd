extends Node

## Variavel para manusear a camera em qualquer lugar
var camera : Camera2D;
## Variavel para indicar que o mundo 1 está existente
var world1 : bool = false;
## Variavel para manusear a linguagem
var languagePtBr : bool = false;
## Variavel para manusear o player
var player;
## Variavel para manusear o navigation presente nos mapas
var navigation;
var worldNode: Level = null;
## Valor até onde o slider deve ir
var sliderValueTo = 0.0;
## Valor atual do slider
var sliderValue = 0.0;
## Verificar se o Esplora está sendo utilizado
export var usingEsplora: bool = true;
## Faz o fadein existir em todas as cenas
var fadeInScene : PackedScene = preload("res://scenes/transitionFadeIn.tscn");
## Variável que controla o intervalo entre os inputs.
onready var inputCooldown: int = 0;
## Intervalo entre inputs
const INPUT_COOLDOWN: int = 12;

func _ready():
	## Prioridade do Global
	process_priority = -99;
	## Faz a janela iniciar no centro
	OS.center_window();

func _process(delta):
	# Reduzir cooldown com o tempo.
	if inputCooldown > 0: inputCooldown -= 1;
	
	## Butão funciona novamente ao colldown funcionar
	if inputCooldown <= 0:
		if ArduinoEsplora.buttonDown == 0 and usingEsplora:
			var event = InputEventAction.new()
			event.action = "ui_accept"
			event.pressed = true
			get_tree().input_event(event)
			print("Input: ", event);
			Global.inputCooldown = Global.INPUT_COOLDOWN;
		
		# Detectar Movimento Vertical
		var _yMove = sign(ArduinoEsplora.axisYControl);
		if _yMove != 0:
			var event = InputEventAction.new();
			event.action = "ui_up" if _yMove < 0 else "ui_down";
			event.pressed = true;
			get_tree().input_event(event);
			Global.inputCooldown = Global.INPUT_COOLDOWN;
			
		# Detectar Movimento Horizontal
		var _xMove = sign(ArduinoEsplora.axisXControl);
		if _xMove != 0:
			var event = InputEventAction.new();
			event.action = "ui_left" if _xMove < 0 else "ui_right";
			event.pressed = true;
			get_tree().input_event(event);
			Global.inputCooldown = Global.INPUT_COOLDOWN;
			
	# Aproximar valor atual da barra para o valor destino.
	var _diff = abs(sliderValueTo - sliderValue);
	var _sp = _diff / 10;
	sliderValue = move_toward(sliderValue, sliderValueTo, _sp);

## Função para fazer a transição entre cenas dentro da global,
## ao inves de botar uma em cada cena	
func transitionToScene(destinyScene : String):
	print("Indo para a cena: ", destinyScene);
	var _trans = fadeInScene.instance();
	_trans.destinyScene = destinyScene;
	add_child(_trans);
