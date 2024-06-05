extends Area2D
onready var pulse = $Pulse

func _process(delta):
	if Input.is_action_just_pressed("Pulse"):
		pulse.set_deferred("Emitting",  true)
