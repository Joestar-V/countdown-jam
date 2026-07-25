extends Node2D

@onready var plots = $plots
@onready var buildings := []
@onready var max_buildings := 4
#
#const BARN = preload("uid://rhdfbuaejr7m")
#const WINDMILL = preload("uid://rlxpw61la8um")
#const CHICKEN_COOP = preload("uid://ds42iybef5saq")
#const COMPOSTER = preload("uid://dealvndyjgyyq")
#const MAGIC_GARDEN = preload("uid://6ii4tvrtdknv")
#const MARKET = preload("uid://bkuddae7q3vsc")
#const TOOL_SHED = preload("uid://cgill5jo1aspp")
#const WELL = preload("uid://d2tli0e8em60a")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#add_building(WELL)
	#add_building(TOOL_SHED)
	#add_building(BARN)
	#add_building(CHICKEN_COOP)
	#add_building(COMPOSTER)
#



func add_building(building : PackedScene):
	for plot in plots.get_children():
		if plot.get_child_count() == 0:
			var built = building.instantiate()
			buildings.append(built)
			plot.add_child(built)
			built.on_built()
			break
