extends Node

var camera : Camera2D;
var world1 : bool = false;
var languagePtBr : bool = false;
var player;
var navigation;
var worldNode: Level = null;
var sliderValueTo = 0.0;
var sliderValue = 0.0;
export var usingEsplora: bool = true;
var fadeInScene : PackedScene = preload("res://scenes/transitionFadeIn.tscn");
## Variável que controla o intervalo entre os inputs.
onready var inputCooldown: int = 0;
## Intervalo entre inputs
const INPUT_COOLDOWN: int = 12;

func _ready():
	process_priority = -99;
	OS.center_window();

func _process(delta):
	# Reduzir cooldown com o tempo.
	if inputCooldown > 0: inputCooldown -= 1;
	
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
	
func transitionToScene(destinyScene : String):
	print("Indo para a cena: ", destinyScene);
	var _trans = fadeInScene.instance();
	_trans.destinyScene = destinyScene;
	add_child(_trans);
