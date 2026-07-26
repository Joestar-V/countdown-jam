extends Building


# Called when the nod

func plant(seed:Seed):
	if seed.slotted:
		if seed.slot.stage ==3 :
			seed.mults.y *= 2
			seed.slot.update_display()


func on_turn_start():
	for seed in Game.game.seedList:
		if seed.slotted:
			if seed.slot.stage ==3 :
				seed.mults.y *= 2
				seed.slot.update_display()



func on_turn_end():
	for seed in Game.game.seedList:
		if seed.slotted:
			if seed.slot.stage == 4 :
				seed.mults.y *= 0.5
				seed.slot.update_display()
