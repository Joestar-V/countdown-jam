extends Node2D


@onready var seed_shop = $seed_shop
@onready var peek: Button = $peek
@export var reroll_cost : int = 5
const APPLE = preload("uid://h25xor7ms780")
var invis = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func freeroll():
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
func reroll():
	if Game.game.moneyCount >= reroll_cost:
		Game.game.moneyCount -= reroll_cost
		for slot in seed_shop.get_children():
			if slot is TextureRect:
				slot.seed.queue_free()
				var seed = Game.game.card_pool.pick_random().instantiate()
				self.add_child(seed)
				seed.default_scale *= 0.9
				seed.hover_scale *= 0.9
				seed.shop = true
				seed.z_index
				seed.homeSlot = slot
				seed.global_position = slot.global_position + ( slot.size/2)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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
	reroll()
