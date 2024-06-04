extends KinematicBody2D
var moveSpeed : float = 120.0;
var runningSpeed : float = 240.0;
var direction : Vector2 = Vector2.ZERO;
var velocity : Vector2 = Vector2.ZERO;
var actualSpeed: float = 0.0;
var accel: float = 12;
var fric: float = 30;
var spritesDict : Dictionary = {
	0: {
		"idle": "Idle_Up",
		"walk": "Walk_Up",
		"run": "Run_Up"
	},
	2: {
		"idle": "Idle_Down",
		"walk": "Walk_Down",
		"run": "Run_Down"
	},
	3: {
		"idle": "Idle_Left",
		"walk": "Walk_Left",
		"run": "Run_Left"
	},
	1: {
		"idle": "Idle_Right",
		"walk": "Walk_Right",
		"run": "Run_Right"
	}
}
var running : bool = false;

func _ready():
	pass # Replace with function body.



func _process(delta):
	# Obter estado de running
	running = Input.get_action_strength("run") != 0.0;
	
	# Obter direção do input do jogador.
	var _axis = Input.get_vector("mv_left", "mv_right", "mv_up", "mv_down");
	var _newSpeed: float = 0.0;
	if _axis != Vector2.ZERO:
		direction = _axis;
		_newSpeed = moveSpeed if !running else runningSpeed;
		
	# Definir velocidade com base no input
	var _sp = accel if _axis != Vector2.ZERO else fric;
	actualSpeed = move_toward(actualSpeed, _newSpeed, _sp);
	velocity = actualSpeed * _axis;
	
	# Mover jogador
	move_and_slide(velocity);
	print("Vel :", velocity.length())
	print("Dir :", direction)
	manage_animation()
	
func manage_animation():
	# Identificar que estado estamos (idle, walk ou run).
	var _state = "idle" if velocity.length() == 0 else "walk";
	_state = "run" if running else _state;
	
	# Obter em graus o valor da direção
	var _degrees = abs(rad2deg(direction.angle()) + 90);
	
	# Obter a chave correspondente a direção
	var _key = floor(_degrees/ 90);
#	
	var _animToPlay = spritesDict[int(_key)][_state];
#	var _animToPlay = spritesDict[0][_state];
	
	$AnimatedSprite.play(_animToPlay);
		

