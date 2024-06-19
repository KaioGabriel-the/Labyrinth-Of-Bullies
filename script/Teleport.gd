extends Area2D

func _on_Teleport_body_entered(body):
	Global.transitionToScene("res://scenes/Victory screen.tscn")
