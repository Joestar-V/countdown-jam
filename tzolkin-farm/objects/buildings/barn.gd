extends Building


# Called every frame. 'delta' is the elapsed time since the previous frame.

#BARNNN
@export var bonus := 2.0

func plant(seed : Seed):
	if seed.slotted:
		if seed.slot.stage == 1 :
			seed.mults *= bonus
			seed.slot.update_display()

func on_turn_start():
	for seed in Game.game.seedList:
		if seed.slotted:
			if seed.slot.stage == 1 :
				seed.mults *= bonus
				seed.slot.update_display()
#
func on_turn_end():
	for seed in Game.game.seedList:
		if seed.slotted:
			if seed.slot.stage == 2 :
				seed.mults /= bonus
				seed.slot.update_display()
