extends Card
class_name Seed


@onready var water_label = $water_label
@onready var title_label = $title_label
@onready var card_border = $card_border


@export_enum("Cereal", "Vegetable", "Fruit", "Root", "Flower") var category = 0
@export_multiline var tooltip_sprout : String = "this is the sprout tooltip"
@export_multiline var tooltip_flower : String = "this is the flower tooltip"
@export_multiline var tooltip_fruit : String = "this is the fruit tooltip"
@export_multiline var tooltip_death : String = "" #empty by default, maybe only appears if something has a death effect

func update_visuals():
	#do stuf
	water_label.text = str(water_cost)
	title_label.text = card_name
	if picture:
		card_image.texture = picture
	
	match rarity:
		0:
			card_border.modulate = Color(1.0, 1.0, 1.0, 1.0)
		1:
			card_border.modulate = Color(0.167, 0.838, 0.0, 1.0)
		2:
			card_border.modulate = Color(0.976, 0.898, 0.0, 1.0)
	
func on_harvest_sprout():
	harvest(0,0,0,[seedPacket]) 
func on_harvest_flower():
	harvest(0,0,0,[seedPacket]) 
func on_harvest_fruit():
	harvest(0,0,0,[seedPacket]) 
func on_harvest_death():
	harvest(0,0,0,[seedPacket]) 


func harvest(foodCount = 0, moneyCount = 0, fertCount = 0, cards = [seedPacket]) -> void:
	Game.game.seedList.erase(self)
	Game.game.actions = 0
	Game.game.harvested = true
	super(foodCount, moneyCount , fertCount, cards)
	
func _on_button_pressed() -> void:
	if slotted:
		if slot.stage != 0 and Game.game.actions > 0:
			print(slot.seed)
			slot.harvest_list()
