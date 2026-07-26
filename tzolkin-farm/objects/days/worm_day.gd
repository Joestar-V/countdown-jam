extends Day


func plant(seed : Seed):
	if seed.slotted:
			
		if seed.slot.stage == 4:
			seed.bonus += Vector3i(0,0,2)
		seed.slot.update_display()
	
		
		
func day_start():
	
	for seed in Game.game.seedList:
					
		if seed.slotted:
			
			if seed.slot.stage == 4:
				seed.bonus += Vector3i(0,0,2)
			seed.slot.update_display()
			
