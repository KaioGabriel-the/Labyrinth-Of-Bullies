extends CanvasLayer
var timeFadeIn : float = 0.01;
var destinyScene : String;
var progress : float = 1.0;

func _process(delta):
	progress = move_toward(progress, 0.0, 0.05);
	$ColorRect.color.a = progress;
	if progress <= 0.0:
		queue_free();
