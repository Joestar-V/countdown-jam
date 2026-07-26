extends Building


func on_week_end():
	var num = 0
	for water in Game.game.water:
		num += 1
		Game.game.foodCount += 1
	
	for i in num:
		Game.game.jukebox.play_food()
		await get_tree().create_timer(.15).timeout
