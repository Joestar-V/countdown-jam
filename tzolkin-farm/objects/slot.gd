extends Node2D
@export var open = false
@onready var seed : Array[Card]
@export var pos = 0
@export_enum("Seed", "Sprout", "Flower", "Fruit", "Death") var stage = 0
const FLASH = preload("uid://c4r08uebnce3l")
@onready var visuals = $visuals

var glowing := false
var glow_time = 0.8

@onready var min_size = Vector2(37,37)

@onready var dirt = $visuals/dirt

@onready var seed_text = $visuals/seed

@onready var sprout = $visuals/sprout
@onready var flowering = $visuals/flowering
@onready var death = $visuals/death

@onready var fruiting = $visuals/fruiting
@onready var slot_hole = $slotHole

const BONUS_COIN = preload("uid://ctjcjrrw23c5v")
const BONUS_FERTIL = preload("uid://7ohukfd6rqda")
const BONUS_FOOD = preload("uid://3du4b373wpkw")

const COIN = preload("uid://cgknl3qcs48vw")
const FERTIL = preload("uid://c8yq733xmh0cc")
const FOOD = preload("uid://c668e1veyatay")

@onready var stats = $visuals/stats
@onready var grid = $visuals/stats/stat_spread/margin/grid



signal finished
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	if stage == null:
		stage = 0
	
	match stage:
		0: seed_text.show()
		1: sprout.show()
		2: flowering.show()
		3: fruiting.show()
		4: death.show()
		
	#stats.show()
	#add_icons(Vector3i(1,1,1))


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
	#update_display()
	
	#if grid.get_child_count() > 0:
	#	stats.show()

func update_display():
	
	for child in grid.get_children():
		child.free()
	
	match stage:
		1:  for sed : Seed in seed: add_icons(sed.sprout,sed.mults)

		2: for sed : Seed in seed: add_icons(sed.flower,sed.mults)

		3: for sed : Seed in seed: add_icons(sed.fruit,sed.mults)

		4: for sed : Seed in seed: add_icons(sed.death,sed.mults)
			#if sed:
				
			
	for sed : Seed in seed:
		if sed:
			add_icons(sed.bonus,sed.mults,true)
			
	#for icon in grid:
		
		
		
	if grid.get_child_count() > 0:
		stats.show()
		
	else:
		stats.hide()
	
	
		
	

func add_icons(spreadI: Vector3i, mults: Vector3, bonus : bool = false,target = grid):
	var spread = Vector3(spreadI.x,spreadI.y,spreadI.z)
	if mults < Vector3(1,1,1):
		spread *= mults
	for x in spread.x:
		var food = TextureRect.new()
		if bonus : food.texture = BONUS_FOOD
		else : food.texture = FOOD
		food.expand_mode = 4
		food.stretch_mode = 5
		food.custom_minimum_size = min_size
		target.add_child(food)
	for y in spread.y:
		var coin = TextureRect.new()
		if bonus : coin.texture = BONUS_COIN
		else : coin.texture = COIN
		coin.expand_mode = 4
		coin.stretch_mode = 5
		coin.custom_minimum_size = min_size
		target.add_child(coin)
	for z in spread.z:
		var fert = TextureRect.new()
		if bonus : fert.texture = BONUS_FERTIL
		else : fert.texture = FERTIL
		fert.expand_mode = 4
		fert.stretch_mode = 5
		fert.custom_minimum_size = min_size
		target.add_child(fert)
	
	
	if mults > Vector3(1,1,1):
		var spread_mult = -spread + (spread * mults)
		bonus = true
		
		for x in spread_mult.x:
			var food = TextureRect.new()
			if bonus : food.texture = BONUS_FOOD
			else : food.texture = FOOD
			food.expand_mode = 4
			food.stretch_mode = 5
			food.custom_minimum_size = min_size
			target.add_child(food)
		for y in spread_mult.y:
			var coin = TextureRect.new()
			if bonus : coin.texture = BONUS_COIN
			else : coin.texture = COIN
			coin.expand_mode = 4
			coin.stretch_mode = 5
			coin.custom_minimum_size = min_size
			target.add_child(coin)
		for z in spread_mult.z:
			var fert = TextureRect.new()
			if bonus : fert.texture = BONUS_FERTIL
			else : fert.texture = FERTIL
			fert.expand_mode = 4
			fert.stretch_mode = 5
			fert.custom_minimum_size = min_size
			target.add_child(fert)


	
