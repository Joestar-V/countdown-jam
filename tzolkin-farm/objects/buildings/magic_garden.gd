extends Building

#LEPRECHAN

@export var good_days_bonus := 1
@export var bad_days_bonus := 0

func on_built():
	Game.game.calender.goodDays += good_days_bonus
	Game.game.calender.badDays += bad_days_bonus

func on_destroyed():
	Game.game.calender.goodDays -= good_days_bonus
	Game.game.calender.badDays -= bad_days_bonus
	queue_free()
