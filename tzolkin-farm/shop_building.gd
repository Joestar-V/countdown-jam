extends Node2D

var building_for_sale : Building
@onready var card_image = $visual/centre/card_image
@onready var title_label = $visual/title_label
@onready var desc = $visual/stat_spread/margin/desc
@onready var stat_spread = $visual/stat_spread

@onready var price_tag = $visual/PriceTag
@onready var cost_tag = $visual/PriceTag/cost_tag
@onready var visual = $visual

@onready var no_room = $visual/no_room


var hovered := false
var hover_scale := Vector2(1.3,1.3)
var default_scale := Vector2(1.2,1.2)

func update_visuals():
	if !building_for_sale:
		return
	
	
	
	card_image.texture = building_for_sale.picture
	title_label.text = building_for_sale.building_name
	desc.text = building_for_sale.tooltip
	cost_tag.text = "$"+ str(building_for_sale.money_cost)

func button_down():
	if Game.game.current_state == Game.game.STATE.SHOP:
		if Game.game.moneyCount >= building_for_sale.money_cost:
			#buy
			pass
		else:
			modulate= Color(1.0, 1.0, 1.0, 1.0).darkened(0.30)



func button_up():
	if Game.game.current_state == Game.game.STATE.SHOP:
		if Game.game.moneyCount >= building_for_sale.money_cost:
			if Game.game.building_keeper.buildings.size() >= Game.game.building_keeper.max_builds:
				print("NO ROOM")
				no_room.show()
				await get_tree().create_timer(1.2).timeout
				no_room.hide()
				return
			#buy
			Game.game.jukebox.play_purchase()
			Game.game.moneyCount -= building_for_sale.money_cost
			remove_child(building_for_sale)
			Game.game.building_keeper.add_building(building_for_sale)
			building_for_sale = null
			queue_free()
			#
			
			#for i in 1:
					#var crd = TINY_CARD.instantiate()
					#goodies.add_child(crd)
					#crd.type = 3
					#crd.global_position = global_position
					#crd.card = seedPacket
					#crd.move_to_resource(Game.game.seedkeeper.discard_pile.recycle_bin.global_position)
			#
			#
		else:
			modulate= Color(1.0, 1.0, 1.0, 1.0)
			#dont buy

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
