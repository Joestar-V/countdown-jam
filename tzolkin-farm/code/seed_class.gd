extends Card
class_name Seed


@onready var water_label = $water_label
@onready var title_label = $title_label
@onready var card_border = $card_border


@export_enum("Cereal", "Vegetable", "Fruit", "Root", "Flower") var category = 0
@export var sprout : Vector3i 
@export var flower : Vector3i 
@export var fruit : Vector3i
@export var death : Vector3i


@export var tooltip_sprout : String = ""
@export var tooltip_flower : String = ""
@export var tooltip_fruit : String = ""
@export var tooltip_death : String = "" #empty by default, maybe only appears if something has a death effect

func update_visuals():
	#do stuf
	stat_spread.seed = self
	stat_spread.set_visuals()
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
		
	await get_tree().create_timer(.1).timeout
	self.scale = default_scale
		
		
func on_harvest_sprout():
	harvest(sprout.x,sprout.y,sprout.z,[seedPacket]) 
func on_harvest_flower():
	harvest(flower.x,flower.y,flower.z,[seedPacket]) 
func on_harvest_fruit():
	harvest(fruit.x,fruit.y,fruit.z,[seedPacket]) 
func on_harvest_death():
	harvest(death.x,death.y,death.z,[seedPacket]) 


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
