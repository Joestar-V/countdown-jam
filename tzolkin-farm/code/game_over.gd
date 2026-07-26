extends Node2D

const TITLE_SCREEN = preload("res://title_screen.tscn")

@onready var building_shop = $building_shop
@onready var tool_shop = $tool_shop

@onready var seed_shop = $seed_shop
@onready var peek: Button = $peek
@export var reroll_cost : int = 5
var invis = false
@onready var days_survived_or_apples: Label = $"Buiildings 4 sale/Label2"
@onready var crops_harvested: Label = $"Buiildings 4 sale2/Label2"
@onready var moeny_gathered: Label = $"Buiildings 4 sale3/Label2"
@onready var total_seeds: Label = $"Buiildings 4 sale4/Label2"

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
	
func set_up_stats(win_or_lose = 0):
	moeny_gathered.text = str(Game.game.money_total)
	crops_harvested.text = str(Game.game.harvest_total)
	total_seeds.text = str(Game.game.total_seeds)
	if win_or_lose == 0:
		days_survived_or_apples.text = str(Game.game.total_days)
	else:
		days_survived_or_apples.text = str(Game.game.total_apples)

func _on_reroll_pressed() -> void:
	get_tree().change_scene_to_file("res://title_screen.tscn")
