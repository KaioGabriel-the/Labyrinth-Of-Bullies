extends KinematicBody2D

onready var timer = $Timer
var speed = 50
var velocity : Vector2 = Vector2.ZERO
var path : Array = []
var navigation_path : Navigation2D = null
var player = null

onready var destinyPos: Vector2 = global_position;
var patrolling : bool = false;
onready var rangeToPursuit: float = 150.0;


func _ready():
	update_references()

func _process(delta):
	update_references()
	if player != null and navigation_path != null:
		generate_path()
		navigate()
		velocity = move_and_slide(velocity)
#		print("Current Position:", global_position)
	enemyPatrolling()

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
		var _destinyPos : Vector2
		if _diff.length() < rangeToPursuit:
			_destinyPos = player.global_position;
			
			
		
		# Verificar se a posição global e a posição global do player são diferentes
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
	var random_direction_x = rand_range(-1,1)
	var random_direction_y = rand_range(-1,1)
	var _destinyPos = global_position + Vector2(random_direction_x, random_direction_y)

func enemyPatrolling():
	if patrolling == true:
		_on_Timer_timeout()
