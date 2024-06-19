extends KinematicBody2D

onready var timer = $Timer
var speed = 50
var velocity : Vector2 = Vector2.ZERO
var path : Array = []
var navigation_path : Navigation2D = null
var player = null

var wanderPos: Vector2
onready var destinyPos: Vector2 = global_position
var patrolling : bool = false
onready var rangeToPursuit: float = 80.0
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
		enemyPatrolling()
		manage_animation()

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
		var _playerPos: Vector2 = player.global_position
		var _diff: Vector2 = _playerPos - global_position
		var distance_ratio = 1.0 - (_diff.length() / rangeToPursuit)
		if distance_ratio > 0.0:
			var shake_intensity = 0.35 + 0.25 * distance_ratio
			shake_intensity = clamp(shake_intensity, 0.35, 0.6)
			Global.camera.shakeCamera(shake_intensity, 0.5)
		
		var _destinyPos : Vector2 = wanderPos
		if _diff.length() < rangeToPursuit:
			_destinyPos = _playerPos

		path = navigation_path.get_simple_path(global_position, _destinyPos, false)
	else:
		print("Player ou Navigation2D não inicializados corretamente.")

func navigate():
	if path.size() > 1:
		velocity = global_position.direction_to(path[1]) * speed
		if global_position.distance_to(path[1]) < 5:
			path.remove(0)
	elif path.size() == 1:
		velocity = global_position.direction_to(player.global_position) * speed

func _on_Timer_timeout():
	var _wanderDistance = randi() % 256
	var random_direction_x = rand_range(-_wanderDistance, _wanderDistance)
	if abs(random_direction_x) < 32:
		random_direction_x = 32 * sign(random_direction_x)
	var random_direction_y = rand_range(-_wanderDistance, _wanderDistance)
	if abs(random_direction_y) < 32:
		random_direction_y = 32 * sign(random_direction_y)
	
	wanderPos = global_position + Vector2(random_direction_x, random_direction_y)
	wanderPos.x = clamp(wanderPos.x, 0, 480)
	wanderPos.y = clamp(wanderPos.y, 0, 480)

func enemyPatrolling():
	if patrolling == true:
		_on_Timer_timeout()

func manage_animation():
	var _state = "idle" if velocity.length() == 0 else "walk"
	var _degrees = abs(rad2deg(direction.angle()) + 90)
	var _key = floor(_degrees / 90)
	var _animToPlay = spritesDict[int(_key)][_state]
	
	animation.play(_animToPlay)

func _on_Area2D_body_entered(body):
	if body is Player:
		Global.player.stunned = true

