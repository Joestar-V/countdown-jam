extends Node2D
class_name gamer

@onready var jukebox = $jukebox
@onready var moon = $moon_group
@onready var end_turn = $"moon_group/Moon/End Turn"


@onready var seedList : Array
@onready var seedkeeper: Node2D = $SeedKeeper
@onready var spots: Node2D = $spots
@onready var spinwheel: Node2D = $Wheel
@onready var wheel: Node2D = $RealWheel

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
@export var building_pool : Array[PackedScene] #add new building here, instantiate them 
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var no_more_turn_ending = false
@export var quota : int = 30:
	set(value):
		quota = value
		resources.quota_label.text = str(int(quota))
@export var quota_increment : int = 10
#@onready var handPos = 0
const APPLE = preload("res://objects/crops/apple.tscn")
const MAIZE = preload("res://objects/crops/maize.tscn")
const BEANS = preload("uid://blmgteof8oxul")
const POTATO = preload("uid://r3v57ntk4jk8")
const SQUASH = preload("uid://0r2fv35jbeuj")
const WHEAT = preload("uid://bd7dp4kyhp0y6")
const GRAPE = preload("uid://36egsxredcru")


const TINY_CARD = preload("uid://p4aq67v85plf")
@onready var gameover: Node2D = $Gameover


enum STATE { PLAY, SHOP, POPUP }
var current_state = STATE.PLAY  
@onready var building_keeper = $building_keeper


@onready var calender: Marker2D = $sundial
@onready var total_apples = 0
@onready var money_total = 0
@onready var harvest_total = 0
@onready var total_days = 0
@onready var total_seeds = 0
@onready var vicroy: Node2D = $vicroy

@onready var water : int = 9:
	set(value):
		water = clamp(value, 0, water_max)
		water_label.text = str(water) +"/"+ str(water_max)
		
@onready var water_max : int = 9:
	set(value):
		water_max = value
		water_label.text = str(water) +"/"+ str(water_max)
		
@onready  var actions : int = 1:
	set(value):
		actions = value
		if actions > 0:
			end_turn.text = "Plant or Harvest"
			end_turn.disabled = true
			moon.glow_stop()
		else:
			end_turn.text = "End Day\n(E or Space)"
			end_turn.disabled = false
			moon.glow()
@onready var fertCount : float = 0:
	set(value):
		
		#if value > fertCount:
			#jukebox.play_fert()
		fertCount = value
		resources.fertilizer_label.text = str(int(value))
@onready var moneyCount : float = 5:
	set(value):
		if moneyCount < value:
			money_total += value - moneyCount
		#if value > moneyCount:
			#jukebox.play_coin()
		moneyCount = value
		resources.money_label.text = str(int(value))
		
@onready var foodCount : float = 30:
	set(value):
		#if value > foodCount:
			#jukebox.play_food()
		if foodCount < value:
			total_apples += value - foodCount
		foodCount = value
		resources.food_label.text = str(int(foodCount))



func _ready() -> void:
	
	jukebox.play_week_start()
	
	Game.game = self
	resources.update_quota(quota)
	#for i in 3:
		#seedkeeper.discard_pile.add_card(APPLE)
		#seedkeeper.discard_pile.add_card(SQUASH)
	for i in 2:
		
		seedkeeper.drawpile.add_card(MAIZE)
		seedkeeper.drawpile.add_card(POTATO)

	seedkeeper.drawpile.add_card(APPLE)
	seedkeeper.drawpile.add_card(GRAPE)
	
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
	wheel.create_circle()
	print(day.title)
	shop.init_shop()
	
	for build in building_keeper.buildings:
		if !build.built: build.build_animation()
	
func red_text():
	water_label.modulate = Color.RED
func white_text():
	water_label.modulate = Color.WHITE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	total_seeds = seedkeeper.drawpile.pile.size() + seedkeeper.discard_pile.pile.size() + seedList.size()
	if dragging:
			end_turn.disabled = true
	else:
		end_turn.disabled = false
func _on_seed_turn_over() -> void:
	pass
	
	
			
	


func _on_end_turn_pressed() -> void:
	if Game.game.current_state == Game.game.STATE.POPUP:
		return
	
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
			
	current_state = STATE.POPUP
	for slot in slotList:
		if slot.pos == 4:
			await slot.harvest_list()
	harvested = false
	actions = actionNum
	no_more_turn_ending = true
	for seed in seedList:
		if seed.slotted:
			if !seed.planted:
				seed.planted = true
				day.plant(seed)
				for building in building_keeper.buildings: building.plant(seed)
				seedkeeper.hand.handList[seed.handPos] = null
			#seed.spinning = true
			print(seed.slot.pos)
			print(slotList.size())
			
			
				
			#seed.slot.update_layout()
			seed.next_slot = slotList[seed.slot.pos+1]
			#seed.slot.update_layout() #starfruit
			#seed.global_position = seed.slot.global_position
			seed.slotted = true
			seed.moving = 2
			#seed.slot.update_display()
	wheel.rotate_next()
	await wheel.finished
	for seed in seedList:
		if seed.planted:
			
			seed.slot.seed.erase(seed)
			seed.slot = seed.next_slot
			seed.slot.seed.append(seed)
	for slot in slotList:
		slot.update_display()
		slot.update_layout()
	
	await seedkeeper.draw_until_full()
	await calender.advance_day()
	
func _on_slot_finished():
	remaining -= 1
	print("Remaining:", remaining)

func weekend():
	
	
	jukebox.play_week_end()
	for building in building_keeper.buildings: building.on_week_end()
	
	remaining = slotList.size()
	
	for slot in slotList: slot.update_display()
	await get_tree().create_timer(0.45).timeout
	
	for slot in slotList:
		slot.finished.connect(_on_slot_finished, CONNECT_ONE_SHOT)
		
		slot.harvest_list()
		
		
	while remaining > 0:
		await get_tree().process_frame
	dragging = false
	dragged = null
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
	
	if await quota_check():
		
		game_over()
	else:
		if calender.total_days >= calender.finalDay:
			victory()
		else:
			open_shop() #this never gets called
				#for spot in slotList:
				#	spot.update_display()
				
			calender.restart()
			wheel.reset_rotate()
	
func open_shop():
	Game.game.current_state = Game.game.STATE.SHOP
	shop.init_shop()
	shop.visible = true
	
	animation_player.play("shop_descend")
	await animation_player.animation_finished
	shopping = true
	Game.game.no_more_turn_ending = false
	actions = 0

	harvested = false
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
	await quota_raise()
	Game.game.current_state = Game.game.STATE.PLAY
	Game.game.no_more_turn_ending = false
	for build in building_keeper.buildings:
		if !build.built: build.build_animation()
		
	
	Game.game.jukebox.play_week_start()
	
func game_over():
	Game.game.current_state = Game.game.STATE.POPUP
	animation_player.play("game_over")
	gameover.set_up_stats(0)
	gameover.visible = true
	
func victory():
	Game.game.current_state = Game.game.STATE.POPUP
	vicroy.set_up_stats(1)
	animation_player.play("win")
	vicroy.visible = true
func quota_check():
	var tween = create_tween()
	var win = false
	if foodCount >= quota:
		win = true
	tween.tween_property(self, "foodCount", clamp(foodCount-quota,0,foodCount), 1.0)
	
	# Pause this function execution until the tween finishes
	await tween.finished
	if win:
		resources.food_label.modulate = Color.GREEN
		return(false)
	else:
		resources.food_label.modulate = Color.RED
		return(true)
	
func quota_raise():
	resources.food_label.modulate = Color.WHITE
	var tween = create_tween()
	
	tween.tween_property(self, "quota", quota+quota_increment, .75)
	
	# Pause this function execution until the tween finishes
	await tween.finished
