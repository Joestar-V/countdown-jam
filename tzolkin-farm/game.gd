extends Node2D
class_name gamer

@onready var seedList : Array
@onready var seedkeeper: Node2D = $SeedKeeper
@onready var spots: Node2D = $spots
@onready var wheel: Node2D = $Wheel
@onready var slotList: Array
@onready var resources: Node2D = $Resources
@onready var harvested = false
@onready var redtext = false
@onready var water_label = $WaterSupply/water_label
@onready var shop: Node2D = $Shop
@onready var shopping = false
@onready var remaining 
@onready var day : Day
@onready var dragging = false
@onready var dragged : Card
@onready  var actionNum = 1
@export var card_pool : Array[PackedScene] #add new cards here, instantiate them 
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var no_more_turn_ending = false
#@onready var handPos = 0
const APPLE = preload("res://objects/crops/apple.tscn")
const MAIZE = preload("res://objects/crops/maize.tscn")
const BEANS = preload("uid://blmgteof8oxul")
const POTATO = preload("uid://r3v57ntk4jk8")
const SQUASH = preload("uid://0r2fv35jbeuj")
const WHEAT = preload("uid://bd7dp4kyhp0y6")
const TINY_CARD = preload("uid://p4aq67v85plf")

enum STATE { PLAY, SHOP, POPUP }
var current_state = STATE.PLAY  
@onready var building_keeper = $building_keeper

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
@onready var fertCount : float = 0:
	set(value):
		fertCount = value
		resources.fertilizer_label.text = str(int(value))
@onready var moneyCount : float = 0:
	set(value):
		moneyCount = value
		resources.money_label.text = str(int(value))
@onready var foodCount : float = 0:
	set(value):
		foodCount = value
		resources.food_label.text = str(int(foodCount))


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
	day = calender.first_day()
	print(day.title)
	shop.freeroll()
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
	if no_more_turn_ending:
		return
	if actions > 0:
		return
	no_more_turn_ending = true
	actions = actionNum

	harvested = false
	
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

				actions = 1
				harvested = false

			else:
				seed.slot.seed.erase(seed)
				seed.slot = slotList[seed.slot.pos+1]
				seed.slot.seed.append(seed)
				seed.global_position = seed.slot.global_position
				seed.slotted = true
				seed.moving = 2
				#seed.slot.update_display()
			
	
	for slot in slotList:
		slot.update_display()
		
	seedkeeper.draw_until_full()
	await calender.advance_day()
	
func _on_slot_finished():
	remaining -= 1
	print("Remaining:", remaining)


func weekend():
	
	
	
	remaining = slotList.size()
	
	for slot in slotList: slot.update_display()
	await get_tree().create_timer(0.45).timeout
	
	for slot in slotList:
		slot.finished.connect(_on_slot_finished, CONNECT_ONE_SHOT)
		
		slot.harvest_list()
		
		
	while remaining > 0:
		await get_tree().process_frame
	for seed in seedList:
		seed.visual.hide()
			
		for i in 1:
			var crd = TINY_CARD.instantiate()
			seed.goodies.add_child(crd)
			crd.type = 3
			crd.global_position = seed.global_position
			crd.card = seed.seedPacket
			crd.move_to_resource(Game.game.seedkeeper.discard_pile.recycle_bin.global_position)
			
	
	
	await get_tree().create_timer(.5).timeout
	for i in range(seedList.size() - 1, -1, -1):
		var seed = seedList[i]
		seedkeeper.hand.handList[seed.handPos] = null
		seed.queue_free()
		seedList.remove_at(i)
		
	open_shop() #this never gets called
	#for spot in slotList:
	#	spot.update_display()
	
	calender.restart()
	
func open_shop():
	Game.game.current_state = Game.game.STATE.SHOP
	shop.freeroll()
	shop.visible = true
	
	animation_player.play("shop_descend")
	await animation_player.animation_finished
	shopping = true
	Game.game.no_more_turn_ending = false
	#while shop.visible:
	#	pass
func close_shop():
	Game.game.current_state = Game.game.STATE.POPUP
	Game.game.no_more_turn_ending = true
	for hand in seedkeeper.hand.handList:
		hand = null
	seedkeeper.reshuffle()
	seedkeeper.draw_until_full()
	animation_player.play("shop_return")

	await animation_player.animation_finished
	shop.visible = false

	shopping = false
	Game.game.current_state = Game.game.STATE.PLAY
	Game.game.no_more_turn_ending = false
	for build in building_keeper.buildings:
		if !build.built: build.build_animation()
	
	
