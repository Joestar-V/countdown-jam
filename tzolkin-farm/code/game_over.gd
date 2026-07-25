extends Node2D

const TITLE_SCREEN = preload("res://title_screen.tscn")

@onready var building_shop = $building_shop
@onready var tool_shop = $tool_shop

@onready var seed_shop = $seed_shop
@onready var peek: Button = $peek
@export var reroll_cost : int = 5
var invis = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#init_shop()
	
		
func _on_peek_pressed() -> void:
	if invis:
		for child in get_children():
			child.visible = true
		invis = false
	else:
		invis = true
		for child in get_children():
			child.visible = false
	peek.visible = true
	#shop is still visible, idk if that interfers with trying to interact with the buildings
	


func _on_reroll_pressed() -> void:
	get_tree().change_scene_to_file("res://title_screen.tscn")
