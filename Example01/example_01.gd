extends StateBase

export(NodePath) var color_rect_path
export(NodePath) var tween_path
export(Color) var target_color
export(float, 0, 10) var duration

var color_rect : ColorRect
var tween : Tween

func on_start(p_args = []):
	color_rect = get_node(color_rect_path) as ColorRect
	tween = get_node(tween_path) as Tween
	
	# Default start color
	var start_color = Color.black
	
	# If previous state passed color_rect color argument, then assign that one as start color
	if p_args.size() > 0:
		start_color = p_args[0]
		
	# Each state can have it's own duration
	tween.stop_all()
	tween.interpolate_property(color_rect, "color", start_color, target_color, duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			invoke_transition("OnClicked", [color_rect.color])
