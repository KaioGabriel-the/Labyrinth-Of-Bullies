extends Node2D
class_name Level


onready var tileColored : TileMap = $Navigation2D/TileColored
onready var tileGray : TileMap = $Navigation2D/TileGray
onready var tileGeneral : TileMap = $Navigation2D/TileGeneral

func _ready():
	AudioManager.playMusic("maze");
	Global.worldNode = self;
	pass

func _on_HSlider_value_changed(value):
	# Se o valor do HSlider for maior que 0.5, TileMap 1 está visível e TileMap 2 está invisível
	if value > 80:
		tileColored.visible = true
		tileColored.set_collision_mask_bit(2 , true)
		tileGray.visible = false
		tileGray.set_collision_mask_bit(2, false)
	# Se o valor do HSlider for menor ou igual a 0.5, TileMap 2 está visível e TileMap 1 está invisível
	elif value < 20:
		tileColored.visible = false
		tileColored.set_collision_mask_bit(2 , false)
		tileGray.visible = true
		tileGray.set_collision_mask_bit(2 , true)

func _process(delta):
	# Tratar valor do slider para pertencer ao intervalo 0.0 - 1.0.
	var _grayScaleValue = Global.sliderValue / 100.0;
	tileColored.material.set_shader_param("gray_scale_intensity", _grayScaleValue);
	tileGray.material.set_shader_param("gray_scale_intensity", _grayScaleValue);
	tileGeneral.material.set_shader_param("gray_scale_intensity", _grayScaleValue);
	_on_HSlider_value_changed(Global.sliderValue);

