extends Node2D
class_name Card

@export var card_name : String 
@export var picture : Texture 
@export_enum("Dirt Cheap", "Scarce", "One of a Kind") var rarity = 0

@export_multiline var tooltip : String = "this is the tooltip"

func _ready():
	update_visuals()

func update_visuals():
	pass
