extends Marker2D
@onready var number: Label = $number
@export var weekLength = 3

@export var radius := 224.0
@export var spacing_degrees := 30.0
#TODO:  Add more days. add gameover.  Get wheel physics working. Add adjacency bonuses. Add tools
@onready var days: Node2D = $days
@onready var total_rotation = 0.0

@onready var currentDay = 0:
	set(value):
		currentDay = value
		number.text = str(weekLength - currentDay)
@export var week = 0
@onready var finalDay = 35
@onready var dayList : Array[Day]
@export var dayPool : Array[PackedScene]
@onready var day_name: Label = $"day name"
@onready var sun: Sprite2D = $Sun
@onready var total_days : int = 0
const QUOTA_DAY = preload("res://objects/days/quota_day.tscn")

const NORMAL_DAY = preload("res://objects/days/normal_day.tscn")
@onready var lastDay : Day
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in dayPool.size():
		dayPool.append(NORMAL_DAY)#this makes it so that the chance of finding a normal day is always 1/2 
		#can use modulus to change this ratio
func _process(delta):
	pass
func first_day():
	currentDay = currentDay
	for i in weekLength:
		dayList.append(dayPool.pick_random().instantiate())
	day_name.text = dayList.front().title
	create_circle()
	dayList.front().biggify()
	dayList.front().day_start()
	return (dayList.pop_front())
	

	
func restart():
	currentDay = 0
	reset_rotate()
	#remake day list
	
func advance_day():
	total_days += 1
	currentDay += 1
	rotate_next()
	if currentDay >= weekLength:
		Game.game.day.tinymize()
		day_name.text = lastDay.title
		lastDay.biggify()
		await Game.game.weekend()
		Game.game.day = first_day()
		day_name.text = Game.game.day.title
		
	else:
		Game.game.day.tinymize()
		Game.game.day =  dayList.pop_front()
		Game.game.day.biggify()
		day_name.text = Game.game.day.title
		Game.game.day.day_start()
		Game.game.no_more_turn_ending = false
		
	
		
func rotate_next():

	var target_rotation = deg_to_rad(-currentDay * spacing_degrees)
	
	create_tween() \
		.tween_property(sun, "rotation", target_rotation, 0.3) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)
	create_tween() \
		.tween_property(days, "rotation", target_rotation, 0.3) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)
	total_rotation = target_rotation
func reset_rotate():
	lastDay.tinymize()
	create_tween() \
		.tween_property(sun, "rotation", 0, 0.3) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)
	create_tween() \
		.tween_property(days, "rotation", 0, 0.3) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)
	total_rotation = 0
func create_circle():
	var i = 0 
	for day in dayList:
		var angle = deg_to_rad(90 + i * spacing_degrees)
		days.add_child(day)

		day.position = Vector2(
			cos(angle),
			sin(angle)
		) * radius
		i += 1
	var day = QUOTA_DAY.instantiate()
	days.add_child(day)
	var angle = deg_to_rad(90 + dayList.size() * spacing_degrees)

	day.position = Vector2(
		cos(angle),
		sin(angle)
	) * radius
	i += 1
	lastDay = day
