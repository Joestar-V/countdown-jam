extends Node2D

var pile : Array[PackedScene]
@onready var draw_count: Label = $draw_count
@onready var pouch = $pouch

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw_count.text = str(pile.size())


	
func add_card(cardScene):
	pile.append(cardScene)
	draw_count.text = str(pile.size())
