extends Card
class_name Seed


@export var water_cost := 1

@export_enum("Cereral", "Vegetable", "Fruit", "Tuber", "Flower") var category = 0


func update_visuals():
	#do stuf
	pass

func on_harvest(state):
	match state:
		pass
