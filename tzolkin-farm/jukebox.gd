extends Node2D
@onready var coin_sound = $coin_sound
@onready var fert_sound = $fert_sound
@onready var chomp_sound = $chomp_sound
@onready var week_start_sound = $week_start_sound
@onready var pop_sound = $pop_sound

@onready var week_end_sound = $week_end_sound
@onready var playlist = $playlist
@onready var purchase_sound = $purchase_sound

func _process(delta):
	if Input.is_action_just_released("Click"): play_pop()

func play_title_theme():
	coin_sound.play()

func play_pop():
	pop_sound.play()

func play_coin():
	coin_sound.play()
	
func play_food():
	chomp_sound.play()
	
func play_fert():
	fert_sound.play()

func play_purchase():
	purchase_sound.play()

func play_week_start(): 
	playlist.stream_paused = true
	week_start_sound.play()
	await week_start_sound.finished
	playlist.stream_paused = false

func play_week_end(): 
	playlist.stream_paused = true
	week_end_sound.play()
	await week_end_sound.finished
	playlist.stream_paused = false
