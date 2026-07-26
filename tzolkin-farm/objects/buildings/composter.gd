extends Building

#COMPOSOSTER

@export var bonus_fert := randi_range(0,2)

func plant(seed : Seed):
	if seed.slotted:
		if seed.slot.stage >= 4 :
			seed.bonus.z += bonus_fert
			seed.slot.update_display()

func on_turn_start():
	bonus_fert = randi_range(0,8)
	
	for seed in Game.game.seedList:
		if seed.slotted:
			if seed.slot.stage >= 4 :
				seed.bonus.z += bonus_fert
				seed.slot.update_display()

#
#
#func on_turn_end():
	
	#for seed in Game.game.seedList:
		#if seed.slotted:
			#if seed.slot.stage == 4 :
				#seed.mults.y *= 0.5
				#seed.slot.update_display()
