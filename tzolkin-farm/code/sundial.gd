extends Marker2D
@onready var number: Label = $number
@export var weekLength = 3

@export var radius := 224.0
@export var spacing_degrees := 30.0
#TODO: Generate day icons in wheel. Get wheel physics working. Add adjacency bonuses. Add tools

@export var currentDay = 0:
	set(value):
		currentDay = value
		number.text = str(weekLength - currentDay)
@export var week = 0
@export var finalDay = 35
@onready var dayList : Array[Day]
@export var dayPool : Array[PackedScene]
@onready var day_name: Label = $"day name"
const NORMAL_DAY = preload("res://objects/days/normal_day.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in dayPool.size():
		dayPool.append(NORMAL_DAY)#this makes it so that the chance of finding a normal day is always 1/2 
		#can use modulus to change this ratio
		
func first_day():
	currentDay = currentDay
	for i in weekLength:
		dayList.append(dayPool.pick_random().instantiate())
	day_name.text = dayList.front().title
	create_circle()
	return (dayList.pop_front())
	

	
func restart():
	currentDay = 0
	#remake day list
	
func advance_day():
	currentDay += 1
	
	if currentDay >= weekLength:
		await Game.game.weekend()
		Game.game.day = first_day()
		day_name.text = Game.game.day.title
	else:
		Game.game.day =  dayList.pop_front()
		day_name.text = Game.game.day.title
		


func create_circle():
	var i = 0
	for day in dayList:
		var angle = deg_to_rad(90 + i * spacing_degrees)
		add_child(day)

		day.position = Vector2(
			cos(angle),
			sin(angle)
		) * radius
		i += 1
