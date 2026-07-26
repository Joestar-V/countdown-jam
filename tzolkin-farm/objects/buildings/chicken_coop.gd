extends Building

#Bawk


func on_seed_init(seed:Seed):
	if seed.category == 0:
		seed.bonus.x += 1
