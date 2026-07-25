extends Day


func daily_bonus(card : Card):
	pass
func day_start():
	
	for slot in Game.game.slotList:
		if slot.stage == 1:
			var tempList : Array[Card]
			for chud in slot.seed:
				tempList.append(chud)
			slot.seed.clear()
			for chud in tempList:
				chud.on_harvest_death()
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
