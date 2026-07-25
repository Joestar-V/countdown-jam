extends Day


	
func plant(seed : Seed):
	if seed.slotted:
		seed.mults *= 2
		seed.slot.update_display()

func day_start():
	for seed in Game.game.seedList:
		if seed.slotted:
			seed.mults *= 2
			seed.slot.update_display()
			
func day_end():
	for seed in Game.game.seedList:
		if seed.slotted:
			seed.mults *= 0.5
			seed.slot.update_display()
