extends CanvasLayer
var timeFadeIn : float = 0.01;
var destinyScene : String;
var progress : float = 0.0;

func _process(delta):
	progress = move_toward(progress, 1.0, 0.01);
	$ColorRect.color.a = progress;
	if progress >= 1.0:
		get_tree().change_scene(destinyScene);
		queue_free();
