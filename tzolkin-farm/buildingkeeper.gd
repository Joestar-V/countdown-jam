extends Node2D

@onready var plots = $plots
@onready var buildings := []
@onready var max_buildings := 4

const BARN = preload("uid://rhdfbuaejr7m")
const WINDMILL = preload("uid://rlxpw61la8um")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_building(BARN)
	add_building(WINDMILL)
	



func add_building(building : PackedScene):
	for plot in plots.get_children():
		if plot.get_child_count() == 0:
			var built = building.instantiate()
			buildings.append(built)
			plot.add_child(built)
			built.on_built()
			break
