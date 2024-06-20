extends Node

var pursuitTimer : int = false;
onready var player : AudioStreamPlayer = get_node("AudioStreamPlayer");

var musicsDict :  Dictionary = {
	"title" : preload("res://music/LabyrinthTitle.mp3"),
	"chase" : preload("res://music/LabyrinthChase.mp3"),
	"maze" : preload("res://music/LanyrinthWalk.mp3"),
	"credits" : preload("res://music/LabyrinthCredits.mp3")
}

func _process(delta):
	if Global.worldNode != null:
		manageMusic()
	
	
func playMusic(_musicKey : String) -> void:
	var _musicToPlay = musicsDict.get(_musicKey);
	if player.stream != _musicToPlay:
		player.stream = _musicToPlay;
		player.play();
		print("TOcando musica: ", _musicKey)

func manageMusic():
	pursuitTimer = move_toward(pursuitTimer,0, 1)
	if pursuitTimer > 0:
		AudioManager.playMusic("chase");
	else:
		AudioManager.playMusic("maze");

func startPursuit():
	pursuitTimer = 60;
	
