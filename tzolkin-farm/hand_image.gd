extends Sprite2D

var time := 0.0
var window_size = DisplayServer.screen_get_size()
var mult = window_size.y * 0.00011
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	position.y += cos(time) * mult
	
