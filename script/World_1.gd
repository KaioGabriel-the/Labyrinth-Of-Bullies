extends Node2D

## DEPRECATED: Código em desuso.

func _process(delta):
	var _grayScaleValue = Global.colorValue / 100.0;
	$"Classroom(10)".material.set_shader_param("gray_scale_intensity", _grayScaleValue)
