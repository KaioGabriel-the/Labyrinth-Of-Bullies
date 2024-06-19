extends Camera2D

var shake_intensity = 0.0
var shake_duration = 0.0
var original_position = Vector2.ZERO

func _ready():
	Global.camera = self
	original_position = position

func _process(delta):
	if shake_duration > 0:
		shake_duration = move_toward(shake_duration, 0.0, delta)
		
		var offset_h = randf() * 2.0 - 1.0  # Gera um valor aleatório entre -1 e 1
		var offset_v = randf() * 2.0 - 1.0  # Gera um valor aleatório entre -1 e 1
		
		position = original_position + Vector2(offset_h, offset_v) * shake_intensity

func shakeCamera(intensity, duration):
	shake_intensity = intensity
	shake_duration = duration

