extends Node2D
class_name Building

@export var building_name : String 
@export var picture : Texture 
@export_enum("Dirt Cheap", "Scarce", "One of a Kind") var rarity = 0

@export_multiline var tooltip : String = "this is the tooltip"

func _ready():
	update_visuals()

func update_visuals():
	pass


func on_built():
	pass

func on_turn_start():
	pass
	
func on_turn_end():
	pass
	
func on_clicked():
	pass
