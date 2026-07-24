extends Node2D
@export var open = false
@onready var seed : Array[Card]
@export var pos = 0
@export_enum("Seed", "Sprout", "Flower", "Fruit", "Death") var stage = 0

@onready var seed_slot = $visuals/seed

@onready var sprout = $visuals/sprout
@onready var flowering = $visuals/flowering
@onready var death = $visuals/death

@onready var fruiting = $visuals/fruiting


signal finished
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match stage:
		0: seed_slot.show()
		1: sprout.show()
		2: flowering.show()
		3: fruiting.show()
		4: death.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
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
