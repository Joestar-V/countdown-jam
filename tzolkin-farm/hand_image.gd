extends Sprite2D

var time := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	position.y += cos(time) * 0.1
