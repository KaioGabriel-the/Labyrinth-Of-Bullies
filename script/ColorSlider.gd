extends HSlider

func _process(delta: float) -> void:
	if Global.usingEsplora:
		# O valor da barra será proveniente do Esplora.
		value = Global.sliderValue;
	else:
		Global.sliderValue = value;
