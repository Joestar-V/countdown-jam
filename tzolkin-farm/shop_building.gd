extends Node2D

var building_for_sale : Building
@onready var card_image = $visual/centre/card_image
@onready var title_label = $visual/title_label
@onready var desc = $visual/stat_spread/margin/desc
@onready var stat_spread = $visual/stat_spread

@onready var price_tag = $visual/PriceTag
@onready var cost_tag = $visual/PriceTag/cost_tag
@onready var visual = $visual


var money_cost := 1

var hovered := false
var hover_scale := Vector2(1.3,1.3)
var default_scale := Vector2(1.2,1.2)

func update_visuals():
	if !building_for_sale:
		return
	
	match building_for_sale.rarity:
		0: money_cost = 10
		1: money_cost = 13
		2: money_cost = 17
	
	
	card_image.texture = building_for_sale.picture
	title_label.text = building_for_sale.building_name
	desc.text = building_for_sale.tooltip
	cost_tag.text = "$"+ str(money_cost)


func zoom():
	if hovered == false:
		hovered = true
		z_index += 10
		stat_spread.show()
		visual.scale = hover_scale
		#create_tween().tween_property(self,"scale",hover_scale,0.2).set_trans(transition_type)
		#await get_tree().create_timer(.2).timeout
	
func unzoom():
	if hovered == true:
		hovered = false
		z_index -= 10
		stat_spread.hide()
		visual.scale = default_scale
