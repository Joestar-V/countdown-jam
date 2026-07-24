extends Node2D


@onready var seed_shop = $seed_shop

const APPLE = preload("uid://h25xor7ms780")

# Called when the node enters the scene tree for the first time.
func _ready():
	for slot in seed_shop.get_children():
		var seed = APPLE.instantiate()
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
