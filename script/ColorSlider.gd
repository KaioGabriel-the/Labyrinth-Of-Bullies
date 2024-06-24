extends HSlider

func _process(delta: float) -> void:
	if Global.usingEsplora:
		# O valor da barra será proveniente do Esplora.
		value = Global.sliderValue;
	else:
		## O valor da barra será o o padrão, alterado pelo mouse
		Global.sliderValue = value;
