extends Node2D
class_name Level


onready var tileColored : TileMap = $TileColored
onready var tileGray : TileMap = $TileGray
onready var tileGeneral : TileMap = $TileGeneral

func _ready():
	Global.worldNode = self;
	pass

func _on_HSlider_value_changed(value):
	# Se o valor do HSlider for maior que 0.5, TileMap 1 está visível e TileMap 2 está invisível
	if value > 0.5:
		tileColored.visible = true
		tileColored.set_collision_mask_bit(2 , true)
		tileGray.visible = false
		tileGray.set_collision_mask_bit(2, false)
	# Se o valor do HSlider for menor ou igual a 0.5, TileMap 2 está visível e TileMap 1 está invisível
	else:
		tileColored.visible = false
		tileColored.set_collision_mask_bit(2 , false)
		tileGray.visible = true
		tileGray.set_collision_mask_bit(2 , true)

func _process(delta):
	tileColored.material.set_shader_param("gray_scale_intensity", Global.colorValue)
	tileGray.material.set_shader_param("gray_scale_intensity", Global.colorValue)
	tileGeneral.material.set_shader_param("gray_scale_intensity", Global.colorValue)
	_on_HSlider_value_changed(Global.colorValue)
	
	if Input.is_action_just_pressed("ui_cancel"):
		pass
