extends Node2D

var building_for_sale : Building
@onready var card_image = $visual/centre/card_image
@onready var title_label = $visual/title_label
@onready var desc = $visual/stat_spread/margin/desc


func update_visuals():
	if !building_for_sale:
		return
	
	card_image.texture = building_for_sale.picture
	title_label.text = building_for_sale.building_name
	desc.text = building_for_sale.tooltip
