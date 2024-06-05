extends Node2D

func _ready():
	pass

func _on_HSlider_value_changed(value):
	# Se o valor do HSlider for maior que 0.5, TileMap 1 está visível e TileMap 2 está invisível
	if value > 0.5:
		$TileMap.visible = true
		$TileMap.set_collision_mask_bit(2 , true)
		$TileMap2.visible = false
		$TileMap2.set_collision_mask_bit(2, false)
	# Se o valor do HSlider for menor ou igual a 0.5, TileMap 2 está visível e TileMap 1 está invisível
	else:
		$TileMap.visible = false
		$TileMap.set_collision_mask_bit(2 , false)
		$TileMap2.visible = true
		$TileMap2.set_collision_mask_bit(2 , true)

func _process(delta):
	$TileMap.material.set_shader_param("gray_scale_intensity", Global.colorValue)
	$TileMap2.material.set_shader_param("gray_scale_intensity", Global.colorValue)
	$TileMap3.material.set_shader_param("gray_scale_intensity", Global.colorValue)
	_on_HSlider_value_changed(Global.colorValue)
	
	if Input.is_action_just_pressed("ui_cancel"):
		pass
