class_name Day
extends Node2D

@export var title = "Ordinary Day"
@export var image : Texture
@export_multiline var description : String = "A beautiful, sunny day. Only as special as you make it."
@onready var bg: Sprite2D = $Sprite2D2
@onready var label: Label = $Label

func daily_bonus(card : Card):
	return
func _process(delta):
	rotation = -get_parent().rotation
func biggify():
	scale = Vector2(1.5,1.5)
	bg.modulate = Color.LIGHT_BLUE

func tinymize():
	scale = Vector2(1.2,1.2)
	bg.modulate = Color.WHITE

#ideas: lucky day, flower day, fruit day, money day, weed day?, rainy day (double rotation), rainy day (free water)?, infestation (fruits halved, flowering bonus)
