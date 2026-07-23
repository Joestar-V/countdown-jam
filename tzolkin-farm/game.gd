extends Node2D

@onready var seedList : Array
@onready var seedpouch: Node2D = $Seedpouch
@onready var spots: Node2D = $spots
@onready var spotList : Array
@onready var wheel: Node2D = $Wheel
@onready var slotList: Array
@onready var resources: Node2D = $Resources

@onready  var actions = 1
@onready  var actionNum = 1

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
	for seed in seedpouch.get_children():
		seedList.append(seed)
		seed.turn_over.connect(_on_seed_turn_over)
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
			seed.planted = true

			#seed.spinning = true
			print(seed.slot.pos)
			print(slotList.size())
			
			if seed.slot.pos >= slotList.size()-1:
				seed.on_harvest_death() #harvest death here
				seedList.erase(seed)
			else:
				seed.slot = slotList[seed.slot.pos+1]
				seed.global_position = seed.slot.position
				seed.slotted = true
				seed.moving = 2
