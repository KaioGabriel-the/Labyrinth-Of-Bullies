extends Node2D


func _process(delta):
	$"Classroom(10)".material.set_shader_param("gray_scale_intensity", Global.colorValue)
