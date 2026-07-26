extends Node2D
@onready var coin_sound = $coin_sound
@onready var fert_sound = $fert_sound
@onready var chomp_sound = $chomp_sound
@onready var week_start_sound = $week_start_sound

@onready var week_end_sound = $week_end_sound


func play_coin():
	coin_sound.play()
	
func play_food():
	chomp_sound.play()
	
func play_fert():
	fert_sound.play()

func play_week_start(): week_start_sound.play()
	
func play_week_end(): week_end_sound.play()
