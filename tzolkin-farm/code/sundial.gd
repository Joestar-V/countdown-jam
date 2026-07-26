extends Marker2D
@onready var number: Label = $number
@export var weekLength = 20

@export var radius := 224.0
@export var spacing_degrees := 30.0
 #Add adjacency bonuses. Add more days
@onready var days: Node2D = $days
@onready var total_rotation = 0.0

@onready var currentDay = 0:
	set(value):
		currentDay = value
		number.text = str(weekLength - currentDay)
@export var week = 0
@onready var finalDay = weekLength*5
@onready var dayList : Array[Day]
@export var dayPoolGood : Array[PackedScene]
@export var dayPoolBad : Array[PackedScene]

@onready var day_name: Label = $"day name"
@onready var day_desc = $"day desc"


@onready var sun: Sprite2D = $Sun
@onready var total_days : int = 0
const QUOTA_DAY = preload("res://objects/days/quota_day.tscn")

const NORMAL_DAY = preload("res://objects/days/normal_day.tscn")
@onready var lastDay : Day

@export var goodDays : int = 5
@export var badDays : int = 3 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#for i in dayPool.size():
	#	dayPool.append(NORMAL_DAY)#this makes it so that the chance of finding a normal day is always 1/2 
		#can use modulus to change this ratio
	pass
func _process(delta):
	pass
	
	
func first_day():
	currentDay = currentDay
	var j = 0
	var k = 0
	
	for i in weekLength-1:
		if j < goodDays:
			dayList.append(dayPoolGood.pick_random().instantiate())
			j += 1
		elif k < badDays:
			dayList.append(dayPoolBad.pick_random().instantiate())
			k += 1
		else:
			dayList.append(NORMAL_DAY.instantiate())
	dayList.shuffle()
	dayList.push_front(NORMAL_DAY.instantiate())
	day_name.text = dayList.front().title
	day_desc.text = dayList.front().description
	create_circle()
	dayList.front().biggify()
	dayList.front().day_start()
	
	for building : Building in Game.game.building_keeper.buildings:
		building.on_turn_start()
	
	
	return (dayList.pop_front())
func firster_day():
	currentDay = currentDay
	var j = 0
	var k = 0
	
	for i in weekLength-1:
		if j < goodDays:
			dayList.append(dayPoolGood.pick_random().instantiate())
			j += 1
		elif k < badDays:
			dayList.append(dayPoolBad.pick_random().instantiate())
			k += 1
		else:
			dayList.append(NORMAL_DAY.instantiate())
	dayList.shuffle()
	dayList.push_front(NORMAL_DAY.instantiate())
	day_name.text = dayList.front().title
	day_desc.text = dayList.front().description
	create_circle()
	dayList.front().biggify()
	dayList.front().day_start()
	
	for building : Building in Game.game.building_keeper.buildings:
		building.on_turn_start()
	
	
	return (dayList.pop_front())

	
func restart():
	currentDay = 0
	reset_rotate()
	
	#remake day list
	
func advance_day():
	Game.game.day.day_end()
	for building : Building in Game.game.building_keeper.buildings: building.on_turn_end()
	total_days += 1
	Game.game.total_days += 1
	currentDay += 1
	rotate_next()
	if currentDay >= weekLength:
		Game.game.day.tinymize()
		day_name.text = lastDay.title
		day_desc.text = lastDay.description
		lastDay.biggify()
		await Game.game.weekend()
		Game.game.day = firster_day()
		day_name.text = Game.game.day.title
		day_desc.text = Game.game.day.description
		
	else:
		Game.game.day.tinymize()
		Game.game.day =  dayList.pop_front()
		Game.game.day.biggify()
		day_name.text = Game.game.day.title
		day_desc.text = Game.game.day.description
		Game.game.day.day_start()
		Game.game.current_state = Game.game.STATE.PLAY
		for building : Building in Game.game.building_keeper.buildings: building.on_turn_start()
		
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
