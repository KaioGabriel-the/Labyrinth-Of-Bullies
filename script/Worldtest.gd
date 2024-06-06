extends Node2D

onready var tilemap : TileMap = $TileColored
onready var tilemap2 : TileMap = $TileGray
onready var tilemap3 : TileMap = $TileGeneral

func _ready():
	pass

func _on_HSlider_value_changed(value):
	# Se o valor do HSlider for maior que 0.5, TileMap 1 está visível e TileMap 2 está invisível
	if value > 0.5:
		tilemap.visible = true
		tilemap.set_collision_mask_bit(2 , true)
		tilemap2.visible = false
		tilemap2.set_collision_mask_bit(2, false)
	# Se o valor do HSlider for menor ou igual a 0.5, TileMap 2 está visível e TileMap 1 está invisível
	else:
		tilemap.visible = false
		tilemap.set_collision_mask_bit(2 , false)
		tilemap2.visible = true
		tilemap2.set_collision_mask_bit(2 , true)

func _process(delta):
	tilemap.material.set_shader_param("gray_scale_intensity", Global.colorValue)
	tilemap2.material.set_shader_param("gray_scale_intensity", Global.colorValue)
	tilemap3.material.set_shader_param("gray_scale_intensity", Global.colorValue)
	_on_HSlider_value_changed(Global.colorValue)
	
	if Input.is_action_just_pressed("ui_cancel"):
		pass
