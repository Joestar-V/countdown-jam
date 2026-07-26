extends Node2D

var skip_tut := false
@onready var tutorial = $tutorial
@onready var jukebox = $jukebox

func _ready():
	jukebox.play_title_theme()

func play():
	if skip_tut:
		start_game()
	elif tutorial.visible:
		start_game()
	else:
		tutorial.show()
	
func start_game():
	get_tree().change_scene_to_file("res://game.tscn")

func quit():
	get_tree().quit()
