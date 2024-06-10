extends Area2D

func _on_Teleport_body_entered(body):
	get_tree().change_scene("res://scenes/Victory screen.tscn")
