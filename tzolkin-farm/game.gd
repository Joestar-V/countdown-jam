extends Node2D

@onready var seedList : Array
@onready var seedkeeper: Node2D = $SeedKeeper
@onready var spots: Node2D = $spots
@onready var spotList : Array
@onready var wheel: Node2D = $Wheel
@onready var slotList: Array
@onready var resources: Node2D = $Resources
@onready var harvested = false
@onready var redtext = false
@onready var water_label = $WaterSupply/water_label
@onready var shop: Node2D = $Shop
@onready var shopping = false
@onready var remaining 

			
@onready  var actionNum = 1
#@onready var handPos = 0
const APPLE = preload("res://objects/crops/apple.tscn")
const MAIZE = preload("res://objects/crops/maize.tscn")
const BEANS = preload("uid://blmgteof8oxul")
const POTATO = preload("uid://r3v57ntk4jk8")
const SQUASH = preload("uid://0r2fv35jbeuj")
const WHEAT = preload("uid://bd7dp4kyhp0y6")




@onready var end_turn = $"End Turn"

@onready var calender: Marker2D = $sundial


@onready var water : int = 10:
	set(value):
		water = clamp(value, 0, water_max)
		water_label.text = str(water) +"/"+ str(water_max)
		
@onready var water_max : int = 10:
	set(value):
		water_max = value
		water_label.text = str(water) +"/"+ str(water_max)
		
@onready  var actions : int = 1:
	set(value):
		actions = value
		if actions > 0:
			end_turn.text = "Plant or Harvest"
			end_turn.disabled = true
		else:
			end_turn.text = "End Day"
			end_turn.disabled = false
@onready var fertCount : int = 0:
	set(value):
		fertCount = value
		resources.fertilizer_label.text = str(value)
@onready var moneyCount : int = 0:
	set(value):
		moneyCount = value
		resources.money_label.text = str(value)
@onready var foodCount : int = 0:
	set(value):
		foodCount = value
		resources.food_label.text = str(foodCount)



func _ready() -> void:
	Game.game = self
	for i in 3:
		seedkeeper.discard_pile.add_card(APPLE)
		seedkeeper.discard_pile.add_card(SQUASH)
	for i in 2:
		seedkeeper.drawpile.add_card(APPLE)
		seedkeeper.drawpile.add_card(MAIZE)
		seedkeeper.drawpile.add_card(POTATO)

	seedkeeper.drawpile.add_card(BEANS)
	seedkeeper.drawpile.add_card(WHEAT)

	seedkeeper.hand.handList.resize(3)
	seedkeeper.draw_until_full()

	#for seed in seedkeeper.hand.get_children():
		#if seed is Card:
		#	seedList.append(seed)
		#seed.turn_over.connect(_on_seed_turn_over)
	#for spot in spots.get_children():
	#	spotList.append(spot)
	var i = 0
	for slot in spots.get_children():
		slotList.append(slot)
		slot.pos = i
		i += 1
	remaining = slotList.size()


func red_text():
	water_label.modulate = Color.RED
func white_text():
	water_label.modulate = Color.WHITE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_seed_turn_over() -> void:
	pass
	
	
			
	


func _on_end_turn_pressed() -> void:
	
	if actions > 0:
		return
	harvested = false
	actions = actionNum
	var i = 0
	if shopping:
		close_shop()
		return
	for seed in seedList:
		if seed.slotted:
			if !seed.planted:
				seed.planted = true
				seedkeeper.hand.handList[seed.handPos] = null
			#seed.spinning = true
			print(seed.slot.pos)
			print(slotList.size())
			
			if seed.slot.pos >= slotList.size()-1:
				seed.on_harvest_death() #harvest death here
				seedList.erase(seed)
				actions = 1
				harvested = false

			else:
				seed.slot.seed.erase(seed)
				seed.slot = slotList[seed.slot.pos+1]
				seed.slot.seed.append(seed)
				seed.global_position = seed.slot.global_position
				seed.slotted = true
				seed.moving = 2
	seedkeeper.draw_until_full()
	await calender.advance_day()

func _on_slot_finished():
	remaining -= 1
	print("Remaining:", remaining)
func weekend():
	
	remaining = slotList.size()
	for slot in slotList:
		slot.finished.connect(_on_slot_finished, CONNECT_ONE_SHOT)
		slot.harvest_list()

	while remaining > 0:
		await get_tree().process_frame
	open_shop() #this never gets called
	#reshuffle deck
	calender.restart()
func open_shop():
	shop.visible = true
	shopping = true
	#while shop.visible:
	#	pass
func close_shop():
	shop.visible = false
	shopping = false
