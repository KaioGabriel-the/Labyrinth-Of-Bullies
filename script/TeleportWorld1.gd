extends Area2D

#TODO: Lembrar de colocar em algum lugar do codigo, um momento onde
#world1 se torna falso novamente(Provavelmente dentro de um botão que volte para o menu inicial)

func _on_Teleport_body_entered(body):
	Global.world1 = true
	Global.transitionToScene("res://scenes/World1.tscn")
