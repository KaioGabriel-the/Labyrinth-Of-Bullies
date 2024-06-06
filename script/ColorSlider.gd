extends HSlider

onready var ass = float(ArduinoEsplora.message_to_receive) 

func _process(delta: float) -> void:
#	value = ass / 100.0;
	var _ang = Time.get_ticks_msec() / 1000.0
	value = 50 + sin(_ang) * 50;
	Global.sliderValue = value / 100.0;
	print(ArduinoEsplora.message_to_receive)
