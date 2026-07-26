extends Building


#wind milll!

func plant(seed:Seed):
	if seed.slotted:
		if seed.slot.stage == 2 :
			seed.bonus.y += 1
			seed.slot.update_display()


func on_turn_start():
	for seed in Game.game.seedList:
		if seed.slotted:
			if seed.slot.stage == 2 :
				seed.bonus.y += 1
				seed.slot.update_display()



func on_turn_end():
	for seed in Game.game.seedList:
		if seed.slotted:
			if seed.slot.stage == 3 :
				seed.bonus.y -= 1
				seed.slot.update_display()
