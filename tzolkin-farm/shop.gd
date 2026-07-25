extends Node2D

@onready var building_shop = $building_shop
@onready var tool_shop = $tool_shop
const SHOP_BUILDING = preload("uid://bf43vioylcck1")

@onready var seed_shop = $seed_shop
@onready var peek: Button = $peek
@export var reroll_cost : int = 5
const APPLE = preload("uid://h25xor7ms780")
var invis = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#init_shop()
	
func init_shop():
	#this is called on shop down
	if invis: _on_peek_pressed()
	
	roll()
		
func roll():
	
	for slot in seed_shop.get_children():
		if slot.seed:
			slot.seed.queue_free()

		var seed = Game.game.card_pool.pick_random().instantiate()
		self.add_child(seed)
		slot.seed = seed
		seed.default_scale *= 0.9
		seed.hover_scale *= 0.9
		seed.shop = true
		seed.z_index
		seed.homeSlot = slot
		seed.global_position = slot.global_position + ( slot.size/2)
		
	for slot in tool_shop.get_children():
		if slot.tool:
			slot.tool.queue_free()
			
	for slot in building_shop.get_children():
		if slot.building:
			slot.building.queue_free()
			
		var build = SHOP_BUILDING.instantiate()
		build.building_for_sale = Game.game.building_pool.pick_random().instantiate()
		slot.add_child(build)
		slot.building = build
		#build.default_scale *= 0.9
		#build.hover_scale *= 0.9
		#build.shop = true
		build.z_index
		#build.homeSlot = slot
		build.global_position = slot.global_position# + ( slot.size/2)
		build.update_visuals()


func _on_peek_pressed() -> void:
	if invis:
		for child in get_children():
			child.visible = true
		invis = false
	else:
		invis = true
		for child in get_children():
			child.visible = false
	peek.visible = true
	#shop is still visible, idk if that interfers with trying to interact with the buildings
	


func _on_reroll_pressed() -> void:
	if Game.game.moneyCount >= reroll_cost:
		Game.game.moneyCount -= reroll_cost
		roll()
