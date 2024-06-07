extends KinematicBody2D
var velocity : Vector2 = Vector2.ZERO
var speed : Vector2
onready var playerNode = Global.player

func _ready():
	pass

func _process(delta):
	# Obter a coordenada do player
#	var _playerPosition = playerNode.global_position
#	var direction = move_toward(global_position, _playerPosition, delta)
	pass
