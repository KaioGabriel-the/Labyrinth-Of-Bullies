extends Node

var pursuitTimer : int = false; ## O timer de perseguição é falso, é o mesmo que 0, significando que o timer não foi ativado
onready var player : AudioStreamPlayer = get_node("AudioStreamPlayer"); ## É referenciado no código

## Dicionario que possui as musicas pré-carregadas
## Antes das virgulas são as chaves
var musicsDict :  Dictionary = {
	"title" : preload("res://music/LabyrinthTitle.mp3"),
	"chase" : preload("res://music/LabyrinthChase.mp3"),
	"maze" : preload("res://music/LanyrinthWalk.mp3"),
	"credits" : preload("res://music/LabyrinthCredits.mp3")
}

## Quando o mundo for existente a função de musica é utilizada
func _process(delta):
	if Global.worldNode != null:
		manageMusic()
	
## A musica é tocada a partir da chave utilizada dentro do codigo, dependente de onde for chamada
func playMusic(_musicKey : String) -> void:
	var _musicToPlay = musicsDict.get(_musicKey); ## Pega a chave da musica
	if player.stream != _musicToPlay:
		player.stream = _musicToPlay;
		player.play();
#		print("Tocando musica: ", _musicKey)

## 
func manageMusic():
	pursuitTimer = move_toward(pursuitTimer,0, 1)
	if pursuitTimer > 0: ## Faz a o som da perseguição ser tocada
		AudioManager.playMusic("chase");
	else: ## Quando o inimigo não esta sendo perseguido, a contagem é iniciado e o move_toward é completado, assim encerrando o som
		AudioManager.playMusic("maze");

func startPursuit():
	pursuitTimer = 60;
	
