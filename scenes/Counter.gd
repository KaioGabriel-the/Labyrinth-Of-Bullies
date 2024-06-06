extends Control

onready var minutes = $Minutes
onready var seconds = $seconds

export var second = 0
export var Minutes = 0
export var start = false

func _process(delta):
	
	if start == true:
		
		if second == 60:
			second = 0
			Minutes += 1
		
		if second < 10:
			seconds.text = ":0" + str(second)
		else:
			seconds.text = ":" + str(second)
			
		if Minutes < 10:
			minutes.text = "0" + str(Minutes)
		else:
			minutes.text = str(Minutes)
#		

func _on_Timer_timeout():
	second += 1
	start = true
