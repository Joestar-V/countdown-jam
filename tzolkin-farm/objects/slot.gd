extends Node2D
@export var open = false
@onready var seed : Array[Card]
@export var pos = 0
@export_enum("Seed", "Sprout", "Flower", "Fruit", "Death") var stage = 0
const FLASH = preload("uid://c4r08uebnce3l")
@onready var visuals = $visuals

var glowing := false
var glow_time = 0.8

@onready var dirt = $visuals/dirt

@onready var seed_slot = $visuals/seed

@onready var sprout = $visuals/sprout
@onready var flowering = $visuals/flowering
@onready var death = $visuals/death

@onready var fruiting = $visuals/fruiting
@onready var slot_hole = $slotHole


signal finished
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	match stage:
		0: seed_slot.show()
		1: sprout.show()
		2: flowering.show()
		3: fruiting.show()
		4: death.show()


func _process(delta: float) -> void:
	if (Game.game.dragging == true) and (Game.game.actions > 0) and (Game.game.water >= Game.game.dragged.water_cost) and (Game.game.fertCount >= self.pos): 
		if !glowing: glow()
	else:
		create_tween().tween_property(self.material,"shader_parameter/flash_amount",0.0,0.0001)

func glow():
	glowing = true
	await create_tween().tween_property(self.material,"shader_parameter/flash_amount",0.3,glow_time).set_trans(Tween.TRANS_SINE).finished
	await create_tween().tween_property(self.material,"shader_parameter/flash_amount",0.0,glow_time).set_trans(Tween.TRANS_SINE).finished
	glowing = false
	
func harvest_list():
	var tempList : Array[Card]
	for chud in seed:
		tempList.append(chud)
	for chud in seed:
		seed.erase(chud)
	for chud in tempList:
		match stage:
			1:
				chud.on_harvest_sprout()
			2:
				chud.on_harvest_flower()
			3:
				chud.on_harvest_fruit()
			4:
				chud.on_harvest_death()
		await chud.finished
	print("Slot", pos, "finished")
	finished.emit()
