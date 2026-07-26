extends Day


func plant(seed : Seed):
	if seed.slotted:
		if seed.slot.stage == 2:
			seed.mults *= 2
		elif seed.slot.stage == 3:
			seed.mults *= 0.5
		seed.slot.update_display()
	
		
		
func day_start():
	
	for slot in Game.game.slotList:
		if slot.stage == 1:
			slot.stage = 4
			await slot.harvest_list()
			slot.stage = 1
			Game.game.actions = Game.game.actionNum
			Game.game.harvested = false
	for seed in Game.game.seedList:
					
		if seed.slotted:
			
			if seed.slot.stage == 2:
				seed.mults *= 2
			seed.slot.update_display()
			
func day_end():
	for seed in Game.game.seedList:
		if seed.slotted:
			if seed.slot.stage == 2:
				seed.mults *= 0.5
			seed.slot.update_display()
