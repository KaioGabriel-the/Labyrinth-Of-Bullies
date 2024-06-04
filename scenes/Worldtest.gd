extends Node2D

func _ready():
	pass

func _on_HSlider_value_changed(value):
	# Se o valor do HSlider for maior que 0.5, TileMap 1 está visível e TileMap 2 está invisível
	if value > 0.5:
		$TileMap.visible = true
		$TileMap.set_deferred("collision_layer",1)
		$TileMap2.visible = false
		$TileMap.set_deferred("collision_layer",5)
	# Se o valor do HSlider for menor ou igual a 0.5, TileMap 2 está visível e TileMap 1 está invisível
	else:
		$TileMap.visible = false
		$TileMap.set_deferred("collision_layer",1)
		$TileMap2.visible = true
		$TileMap.set_deferred("collision_layer",5)

func _process(delta):
	$TileMap.material.set_shader_param("gray_scale_intensity", Global.colorValue)
	_on_HSlider_value_changed(Global.colorValue)
