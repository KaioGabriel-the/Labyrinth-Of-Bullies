extends HSlider

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	Global.colorValue = value / 100.0;
