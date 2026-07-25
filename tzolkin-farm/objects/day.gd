class_name Day
extends Node2D

@export var title = "Quota Day"
@export var image : Texture
@export_multiline var description : String = "The last day of a season. If you don't meet the food quota, it's game over."
@onready var bg: Sprite2D = $Sprite2D2
@onready var label: Label = $Label
@onready var button: Button = $Button

func _ready() -> void:
	button.tooltip_text = description
func daily_bonus(card : Card):
	return
func day_start():
	pass
func _process(delta):
	rotation = -get_parent().rotation
func biggify():
	scale = Vector2(1.5,1.5)
	bg.modulate = Color.LIGHT_BLUE

func tinymize():
	scale = Vector2(1.2,1.2)
	bg.modulate = Color.WHITE

#ideas: lucky day, flower day, fruit day, money day, weed day?, rainy day (double rotation), rainy day (free water)?, infestation (fruits halved, flowering bonus)
