extends Building

@export var water_bonus := 3
#WELLLL WELL WEL

func on_built():
	Game.game.water_max += water_bonus
	Game.game.water += water_bonus

func on_destroyed():
	Game.game.water_max -= water_bonus
	Game.game.water -= water_bonus
	queue_free()
