extends Node2D

@onready var seedList : Array
@onready var seedkeeper: Node2D = $SeedKeeper
@onready var spots: Node2D = $spots
@onready var spotList : Array
@onready var wheel: Node2D = $Wheel
@onready var slotList: Array
@onready var resources: Node2D = $Resources
@onready var harvested = false


			
@onready  var actionNum = 1
#@onready var handPos = 0
const APPLE = preload("res://objects/crops/apple.tscn")
@onready var end_turn = $"End Turn"


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
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.game = self
	for i in 3:
		seedkeeper.discard_pile.add_card(APPLE)
	for i in 4:
		seedkeeper.drawpile.add_card(APPLE)
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
	#for slot in slotList:
	#	i+= 1
	#	if i >= spotList.size():
	#		i  = 0
	#	slot.global_position = spotList[i].global_position
	
	#slotList.pop_back()
	#slotList.push_front(slotList)
	#for slot in slotList:
			#
		#if slot.seed and slot.seed != null:
			#
			#if i >= slotList.size():
				#slot.seed.slot = slotList.front()
				#slotList.front().seed = slot.seed
				#slot.seed.global_position = slotList.front().global_position
				#slot.seed = null
			#else:
				#slot.seed.slot = slotList[slot+1]
				#slotList[slot+1].seed = slot.seed
				#slot.seed.global_position = slotList[slot+1].global_position
				#slot.seed = null
			
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
				seed.slot = slotList[seed.slot.pos+1]
				seed.global_position = seed.slot.position
				seed.slotted = true
				seed.moving = 2
	seedkeeper.draw_until_full()
