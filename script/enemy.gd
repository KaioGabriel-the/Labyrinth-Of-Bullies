extends KinematicBody2D

var speed = 30;
var motion = Vector2.ZERO;
# O caminho que o inimigo irá seguir
var path : Array = [];
var NavigationNode = null;
var player = null;

func _ready():
	if get_tree().has_group("nav"):
		NavigationNode = get_tree().get_nodes_in_group("nav")[0];
	if get_tree().has_group("player"):
		player = get_tree().get_nodes_in_group("player")[0];
		
func _physics_process(delta):
	create_path();
	goto()
	
	motion = move_and_slide(motion)
func create_path():
	#Função responsavel por criar o caminho e adicionar-lo em nossa array
	if NavigationNode != null and player != null:
		path = NavigationNode.get_simple_path(global_position,player.global_position,false);
		
func goto():
	if path.size() > 0:
		motion = global_position.direction_to(path[1]) * speed
		
