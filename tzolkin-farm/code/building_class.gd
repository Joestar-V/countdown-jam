extends Node2D
class_name Building

#@onready var packed_scene : PackedScene
@onready var built = false
@export var building_name : String 
@export var picture : Texture 
@export_enum("Dirt Cheap", "Scarce", "One of a Kind") var rarity = 0

@export_multiline var tooltip : String = "this is the tooltip"

var money_cost 




func _ready():
	#packed_scene = load(scene_file_path)
	modulate = Color(1.0, 1.0, 1.0, 0.0)
	match rarity:
		0: money_cost = 10
		1: money_cost = 14
		2: money_cost = 18

func build_animation():
	built = true
	
	modulate = Color(1.0, 1.0, 1.0, 0.0)
	create_tween().tween_property(self,"modulate",Color(1,1,1,1),0.99)#.set_trans(transition_type)
	#play sound or smnt
	await get_tree().create_timer(1.34).timeout
	create_tween().tween_property(self.material,"shader_parameter/color",Color(1.0, 0.94, 0.1, 0.0),0.63)#.set_trans(Tween.TRANS_SINE)
	
	on_built()
	


func on_built():
	pass

func on_destroyed():
	queue_free()

func on_turn_start():
	pass
	
func on_turn_end():
	pass

func on_week_start():
	pass
	
func on_week_end():
	pass

#func on_harvest():
#	pass

#func on_clicked():
#	pass
