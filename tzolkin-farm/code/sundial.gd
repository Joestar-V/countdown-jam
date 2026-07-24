extends Marker2D
@onready var number: Label = $number
@export var weekLength = 3

@export var currentDay = 0:
	set(value):
		currentDay = value
		number.text = str(weekLength - currentDay)
@export var week = 0
@export var finalDay = 35
@onready var dayList : Array[Day]
@export var dayPool : Array[PackedScene]
@onready var day_name: Label = $"day name"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func first_day():
	currentDay = currentDay
	for i in weekLength:
		dayList.append(dayPool.pick_random().instantiate())
	day_name.text = dayList.front().title
	return (dayList.pop_front())
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func restart():
	currentDay = 0
	#remake day list
func advance_day():
	currentDay += 1
	Game.game.day =  dayList.pop_front()
	day_name.text = Game.game.day.title
	if currentDay >= weekLength:
		await Game.game.weekend()
