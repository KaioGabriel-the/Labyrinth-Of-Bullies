extends KinematicBody2D

var moveSpeed : float = 120.0
var runningSpeed : float = 240.0
var direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
var actualSpeed: float = 0.0
var accel: float = 12
var fric: float = 30
var spritesDict : Dictionary = {
	0: {
		"idle": "Idle_Up",
		"walk": "Walk_Up",
		"run": "Run_Up",
		"death" : "Death_Up"
	},
	2: {
		"idle": "Idle_Down",
		"walk": "Walk_Down",
		"run": "Run_Down",
		"death" : "Death_Down"
	},
	3: {
		"idle": "Idle_Left",
		"walk": "Walk_Left",
		"run": "Run_Left",
		"death" : "Death_Left"
	},
	1: {
		"idle": "Idle_Right",
		"walk": "Walk_Right",
		"run": "Run_Right",
		"death" : "Death_Right"
	}
}
var running : bool
var stunned: bool = false
var stunnedTimer: int = false
var _axis : Vector2 = Vector2.ZERO
onready var animation : AnimatedSprite = $AnimatedSprite

func _ready():
	pass # Replace with function body.

func _process(delta):
	# Obter estado de running
	if velocity.length() == 0:
		running = false
	else:
		running = Input.is_action_pressed("run")
	
	# Obter direção do input do jogador.
	if stunned == true:
		_axis = Vector2.ZERO
	else:
		_axis = Input.get_vector("mv_left", "mv_right", "mv_up", "mv_down")
	var _newSpeed: float = 0.0
	if _axis != Vector2.ZERO:
		direction = _axis
		_newSpeed = moveSpeed if !running else runningSpeed
		
	# Definir velocidade com base no input
	var _sp = accel if _axis != Vector2.ZERO else fric
	actualSpeed = move_toward(actualSpeed, _newSpeed, _sp)
	velocity = actualSpeed * _axis
	
	# Checar stun
	if Global.worldNode != null:
		var _tmap1: TileMap = Global.worldNode.tileColored
		var _tmap2: TileMap = Global.worldNode.tileGray
		var _tmaps = [_tmap1, _tmap2]
		for i in range(len(_tmaps)):
			var _tmap = _tmaps[i]
			var _consider = (i == 1 and Global.colorValue < 0.50) or (i == 0 and Global.colorValue > 0.50)
			if !_consider:
				continue
			# Converte a posição do mundo para a posição no tilemap
			var tile_position = _tmap.world_to_map(global_position - Vector2(0, 8))
			# Obtém o índice do tile na posição convertida
			var tile_index = _tmap.get_cellv(tile_position)
			if tile_index != -1:
				stunned = true
	
	# Manage stun
	if stunned: stunnedTimer = 64
	elif stunnedTimer > 0: stunnedTimer -= 1
		
	# Mover jogador
	if stunnedTimer <= 0:
		modulate = Color.white
		move_and_slide(velocity)
	else:
		modulate = Color.red
		print("Morri.")

	manage_animation()
	
func manage_animation():
	# Identificar que estado estamos (idle, walk ou run).
	var _state = "idle" if velocity.length() == 0 else "walk"
	_state = "run" if running else _state
	if stunned == true:
		_state = "death"
		play_death_animation()
		return
	# Obter em graus o valor da direção
	var _degrees = abs(rad2deg(direction.angle()) + 90)
	
	# Obter a chave correspondente a direção
	var _key = floor(_degrees / 90)
	var _animToPlay = spritesDict[int(_key)][_state]
	
	animation.play(_animToPlay)
		
func play_death_animation():
	var _degrees = abs(rad2deg(direction.angle()) + 90)
	var _key = floor(_degrees / 90)
	var _animToPlay = spritesDict[int(_key)]["death"]
	
	animation.play(_animToPlay)
	animation.connect("animation_finished", self, "_on_death_animation_finished")

func _on_death_animation_finished():
	animation.stop()
	animation.frame = animation.frames.get_frame_count(animation.animation) - 1

