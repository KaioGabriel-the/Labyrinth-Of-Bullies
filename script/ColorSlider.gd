extends HSlider

func _process(delta: float) -> void:
	Global.colorValue = value / 100.0;
