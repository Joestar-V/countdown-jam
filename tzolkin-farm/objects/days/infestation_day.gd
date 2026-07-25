extends Day


func daily_bonus(card : Card):
	pass
func day_start():
	for seed in Game.game.seedList:
		if seed.slotted:
			if seed.slot.stage == 2:
				seed.mults *= 2
			elif seed.slot.stage == 3:
				seed.mults *= 0.5
			seed.slot.update_display()
			
func day_end():
	for seed in Game.game.seedList:
		if seed.slotted:
			if seed.slot.stage == 2:
				seed.mults *= 0.5
			elif seed.slot.stage == 3:
				seed.mults *= 2
			seed.slot.update_display()
