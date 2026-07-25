extends Node2D

var skip_tut := false

func play():
	if skip_tut:
		start_game()
	else:
		pass
		

func start_game():
	get_tree().change_scene_to_file("res://game.tscn")

func quit():
	get_tree().quit()
