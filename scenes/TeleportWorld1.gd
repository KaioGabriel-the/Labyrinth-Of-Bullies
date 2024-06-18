extends Area2D



func _on_Teleport_body_entered(body):
	get_tree().change_scene("res://scenes/World1.tscn")
