extends HSlider

onready var ass = float(ArduinoEsplora.message_to_receive) 

func _process(delta: float) -> void:
	if Global.usingEsplora:
		# O valor da barra será proveniente do Esplora.
		value = Global.sliderValue;
	else:
		Global.sliderValue = value;
