extends CanvasLayer


func _process(delta):
	pass
	
func changeLanguage():
	if Global.languagePtBr == true:
		$TextureRect/Label.text = "Voce Fugiu"
	else:
		$TextureRect/Label.text = "You Escaped"
