extends Node2D

var pile : Array[PackedScene]
@onready var draw_count: Label = $draw_count

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw_count.text = str(pile.size())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func add_card(cardScene):
	pile.append(cardScene)
	draw_count.text = str(pile.size())
