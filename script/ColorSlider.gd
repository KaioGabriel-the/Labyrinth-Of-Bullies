extends HSlider

func _process(delta: float) -> void:
	if Global.usingEsplora:
		# O valor da barra será proveniente do Esplora.
		value = Global.sliderValue;
		print("value: ", value);
#		print("Valor da barra agora é: ", value)
	else:
		Global.sliderValue = value;
