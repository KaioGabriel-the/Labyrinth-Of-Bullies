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

func _ready():
	OS.center_window();

func _process(delta):
	# Aproximar valor atual da barra para o valor destino.
	var _diff = abs(sliderValueTo - sliderValue);
	var _sp = _diff / 10;
	sliderValue = move_toward(sliderValue, sliderValueTo, _sp);
	
func transitionToScene(destinyScene : String):
	print("Indo para a cena: ", destinyScene);
	var _trans = fadeInScene.instance();
	_trans.destinyScene = destinyScene;
	add_child(_trans);
