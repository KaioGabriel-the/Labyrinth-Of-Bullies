extends Node

var world1 : bool = false
var languagePtBr : bool = false
var player
var navigation
var worldNode: Level;
var sliderValueTo = 0.0;
var sliderValue = 0.0;
export var usingEsplora: bool = true;

func _process(delta):
	# Aproximar valor atual da barra para o valor destino.
	var _diff = abs(sliderValueTo - sliderValue);
	var _sp = _diff / 10;
	sliderValue = move_toward(sliderValue, sliderValueTo, _sp)
