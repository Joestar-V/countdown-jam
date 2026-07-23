extends Card
class_name Seed


@onready var water_label = $water_label
@onready var title_label = $title_label

@export var water_cost := 1

@export_enum("Cereral", "Vegetable", "Fruit", "Tuber", "Flower") var category = 0
@export_multiline var tooltip_sprout : String = "this is the sprout tooltip"
@export_multiline var tooltip_flower : String = "this is the flower tooltip"
@export_multiline var tooltip_fruit : String = "this is the fruit tooltip"
@export_multiline var tooltip_death : String = "" #empty by default, maybe only appears if something has a death effect


func update_visuals():
	#do stuf
	water_label.text = str(water_cost)
	title_label.text = card_name

func on_harvest_sprout():
	pass
func on_harvest_flower():
	pass #maybe emit something here
func on_harvest_fruit():
	pass 
func on_harvest_death():

	harvest()
func harvest(foodCount = 0, moneyCount = 0, fertCount = 0, cards = []) -> void:
	Game.game.seedList.erase(self)
	super(foodCount, moneyCount , fertCount, cards)
	
func _on_button_pressed() -> void:
	if slotted:
		if slot.stage != 0:
			match slot.stage:
				1:
					on_harvest_sprout()
				2:
					on_harvest_flower()
				3:
					on_harvest_fruit()
				4:
					on_harvest_death()
