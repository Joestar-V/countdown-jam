class_name Day
extends Node2D

@export var title = "Ordinary Day"
@export var image : Texture
@export_multiline var description : String = "A beautiful, sunny day. Only as special as you make it."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func daily_bonus(card : Card):
	return

#ideas: lucky day, flower day, fruit day, money day, weed day?, rainy day (double rotation), rainy day (free water)?, infestation (fruits halved, flowering bonus)
