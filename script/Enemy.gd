extends KinematicBody2D

## Variavel para utilizar o timer filha do inimigo
onready var timer = $Timer;
## Acumular a velocidade do inimigo
var speed = 50;
## Velocidade final do inimigo
var velocity : Vector2 = Vector2.ZERO;
## Array para guardar o caminho que o inimigo deve caminhar
var path : Array = [];
## Função da godot para identificar o chão para navegar pelo mapa
var navigation_path : Navigation2D = null;
## Referencia ao player existente no jogo
var player = null;

## Posição onde o inimigo irá  vagar
var wanderPos: Vector2;
## Posição destino do inimigo
onready var destinyPos: Vector2 = global_position;
## Variavel para verificar se o inimigo está patrulhando
var patrolling : bool = false;
## Acumular o valor do raio de perseguição do inimigo
## se o player estiver dentro dela, será perseguido pelo inimigo
onready var rangeToPursuit: float = 80.0;
## Direção para onde o inimigo se movimenta
var direction = Vector2.ZERO;
## Variavel para utilizar as animções do inimigo
onready var animation = get_node("AnimatedSprite");

## Dicionario com chaves para utilização das animações
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
	update_references();

func _process(delta):
	update();
	update_references();
	## Se player e os caminhos não forem existentes, as funções não são ativas
	if player != null and navigation_path != null:
		generate_path();
		navigate();
		velocity = move_and_slide(velocity);
		direction = velocity.normalized();
		enemyPatrolling();
		manage_animation();

func update_references():
	## Atualização da referencia do caminho
	if Global.navigation != null:
		navigation_path = Global.navigation;
	else:
		print("Navigation2D não inicializado corretamente.");

	if Global.player != null:
		player = Global.player;
	else:
		print("Player não inicializado corretamente.");

## Função que gera o caminho que o inimigo vai percorrer.
func generate_path():
	# Se existir o player, e já houver definido o trajeto.
	if player != null and navigation_path != null:
		var _playerPos: Vector2 = player.global_position;
		var _diff: Vector2 = _playerPos - global_position;
		# Cria-se um valor parâmetro baseado na distancia do player até o inimigo.
		# Se distance_to_ratio < 0, significa que o Player tá fora do range.
		# Se distance_to_ratio > 0, significa que o Player tá dentro do range.
		# Quanto mais próximo de 1.0, mais próximo o Player está do inimigo.
		var distance_ratio = 1.0 - (_diff.length() / rangeToPursuit);
		# Por padrão, o zoom sempre será esse.
		var _zoom = 0.25;
		if distance_ratio > 0.0:	# Player dentro do range
			_zoom = 0.20;			# Câmera se aproxima
			var intensity = 0.35 + 0.25 * distance_ratio;	# Intensidade varia de 0.35 a 0.60.
			intensity = clamp(intensity, 0.35, 0.60);
			Global.camera.shakeCamera(intensity, 0.5);
		
		Global.camera.zoom = lerp(Global.camera.zoom, Vector2(_zoom, _zoom), 0.069);
		
		var _destinyPos : Vector2 = wanderPos;
		if _diff.length() < rangeToPursuit:
			AudioManager.startPursuit()
			_destinyPos = _playerPos;
		path = navigation_path.get_simple_path(global_position, _destinyPos, false);
	else:
		print("Player ou Navigation2D não inicializados corretamente.");

func navigate():
	## Se o caminho for existente, o inimigo se o move para a posição na velocidade predefinida
	if path.size() > 1:
		velocity = global_position.direction_to(path[1]) * speed;
		## O caminho anterior sempre é removido, para evitar problema
		if global_position.distance_to(path[1]) < 5:
			path.remove(0);
	## Se o caminho for existente, o inimigo se movimentará até o player se possivel
	elif path.size() == 1:
		velocity = global_position.direction_to(player.global_position) * speed;

func _on_Timer_timeout():
	## Numero aleatorido inteiro de 0 a 255
	var _wanderDistance = randi() % 256;
	## Randomiza se o valor andando será direita ou esquerda
	var random_direction_x = rand_range(-_wanderDistance, _wanderDistance);
	## Se o valor for menor que 32, irá pegar o proprio 32,
	## e pegara o sinal do numero aleatorio escolhido anteriormente
	## para o calculo matematico
	if abs(random_direction_x) < 32:
		random_direction_x = 32 * sign(random_direction_x);
	## Randomiza se o valor andado será para cima pu para baixo
	var random_direction_y = rand_range(-_wanderDistance, _wanderDistance);
	if abs(random_direction_y) < 32:
		random_direction_y = 32 * sign(random_direction_y);
	
	wanderPos = global_position + Vector2(random_direction_x, random_direction_y);
	wanderPos.x = clamp(wanderPos.x, 0, 480);
	wanderPos.y = clamp(wanderPos.y, 0, 480);

func enemyPatrolling():
	## Enquanto estiver patrulhando, um timer é ativado para de tempos em tempos
	## o inimigo escolher caminhos aleatorios
	if patrolling == true:
		_on_Timer_timeout();

func manage_animation():
	var _state = "idle" if velocity.length() == 0 else "walk";
	## Utilizaum calculo matematico apartir de rad, em que irá um valor
	var _degrees = abs(rad2deg(direction.angle()) + 90);
	## Quando esse valor for divido por 90, irá dar um dos numeros da chave
	var _key = floor(_degrees / 90);
	## Assim o animToPlay irá utilizar irá usar a chave e o estado para as animções
	var _animToPlay = spritesDict[int(_key)][_state];
	
	animation.play(_animToPlay);

func _on_Area2D_body_entered(body):
	## Se area que entrar dentro do inimigo for o player, o player ficará "stunado"
	## Des
	if body is Player:
		Global.player.stunned = true;
