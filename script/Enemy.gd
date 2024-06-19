extends KinematicBody2D

onready var timer = $Timer
var speed = 50
var velocity : Vector2 = Vector2.ZERO
var path : Array = []
var navigation_path : Navigation2D = null
var player = null

## Posição destino enquanto está patrulhando. Essa variável será aleatorizada no timeout.
var wanderPos: Vector2 ;
onready var destinyPos: Vector2 = global_position;
var patrolling : bool = false;
onready var rangeToPursuit: float = 80.0;
var direction = Vector2.ZERO
onready var animation = get_node("AnimatedSprite")

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

func _ready():
	update_references()

func _process(delta):
	update()
	update_references()
	if player != null and navigation_path != null:
		generate_path()
		navigate()
		velocity = move_and_slide(velocity)
		direction = velocity.normalized()
#		print("Current Position:", global_position)
	enemyPatrolling()
	manage_animation()

## Atualiza o trajeto do inimigo
func update_references():
	if Global.navigation != null:
		navigation_path = Global.navigation
	else:
		print("Navigation2D não inicializado corretamente.")

	if Global.player != null:
		player = Global.player
	else:
		print("Player não inicializado corretamente.")

func generate_path():
	if player != null and navigation_path != null:
		
		# Verifica se o player está dentro do range:
		var _playerPos: Vector2 = player.global_position;
		var _diff: Vector2 = _playerPos - global_position;
#		print("Distância até o player: ", _diff.length())
		
		# Por padrão, o inimigo vai se mover até essa posição.
		# TODO: Colocar um valor mais apropriado.
		var _destinyPos : Vector2 = wanderPos
		if _diff.length() < rangeToPursuit:
			_destinyPos = player.global_position;


		# Verificar se a posição global e a posição global do player são diferentes
#		print("cabeçona");
#		print("Pos: %s, Destino: %s" % [global_position, _destinyPos])
		path = navigation_path.get_simple_path(global_position, _destinyPos, false);
			
		
	else:
		print("Player ou Navigation2D não inicializados corretamente.")

func navigate():
	if path.size() > 1:
		velocity = global_position.direction_to(path[1]) * speed
		if global_position.distance_to(path[1]) < 5: # Ajuste a margem conforme necessário
			path.remove(0)
	elif path.size() == 1:
		velocity = global_position.direction_to(player.global_position) * speed


func _on_Timer_timeout():
	var _wanderDistance = randi() % 256;
	var random_direction_x = rand_range(-_wanderDistance, _wanderDistance)
	if abs(random_direction_x) < 32: random_direction_x = 32 * sign(random_direction_x)
	var random_direction_y = rand_range(-_wanderDistance, _wanderDistance)
	if abs(random_direction_y) < 32: random_direction_y = 32 * sign(random_direction_y)
	wanderPos = global_position + Vector2(random_direction_x, random_direction_y)
	wanderPos.x = clamp(wanderPos.x, 0, 480);
	wanderPos.y = clamp(wanderPos.y, 0, 480);
#	wanderPos = wanderPos.linear_interpolate(Vector2(250, 250), 0.20);
	
	var _diff = global_position - wanderPos;
	print("Diferença de posicoes: ", _diff)
	print("Inimigo indo para: ", wanderPos)
	

func enemyPatrolling():
	if patrolling == true:
		_on_Timer_timeout()

func manage_animation():
	# Identificar que estado estamos (idle, walk ou run).
	var _state = "idle" if velocity.length() == 0 else "walk"
		
	# Obter em graus o valor da direção
	var _degrees = abs(rad2deg(direction.angle()) + 90)
	
	# Obter a chave correspondente a direção
	var _key = floor(_degrees / 90)
	var _animToPlay = spritesDict[int(_key)][_state]
	
	animation.play(_animToPlay)


func _on_Area2D_body_entered(body):
	if body is Player:
		Global.player.stunned = true
