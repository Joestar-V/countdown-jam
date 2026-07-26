extends Building

#COMPOSOSTER

@onready var bonus_fert : int
@export var min_fert := 0
@export var max_fert := 2


func plant(seed : Seed):
	bonus_fert = randi_range(min_fert,max_fert)
	if seed.slotted:
		if seed.slot.stage >= 4 :
			seed.bonus.z += bonus_fert
			seed.slot.update_display()

func on_turn_start():
	bonus_fert = randi_range(min_fert,max_fert)
	
	for seed in Game.game.seedList:
		if seed.slotted:
			if seed.slot.stage >= 4 :
				seed.bonus.z += bonus_fert
				seed.slot.update_display()

#
#
func on_turn_end():
	for seed in Game.game.seedList:
		if seed.slotted:
			if seed.slot.stage >= 4 :
				seed.slot.update_display()
