extends Node2D

var glowing := false
@onready var moon = $Moon

func glow():
	create_tween().tween_property(moon.material,"shader_parameter/width",12.0,0.2)
	create_tween().tween_property(moon,"position",Vector2(0,-55),0.1)
	
func glow_stop():
	create_tween().tween_property(moon.material,"shader_parameter/width",0.0,0.2).set_trans(Tween.TRANS_BOUNCE)
	create_tween().tween_property(moon,"position",Vector2(0,0),0.1)
