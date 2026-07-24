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
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentDay = currentDay
	for i in weekLength:
		dayList.append(dayPool.pick_random().instantiate())
	Game.game.day =  dayList.pop_front()
	print(Game.game.day.title)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func restart():
	currentDay = 0
	#remake day list
func advance_day():
	currentDay += 1
	Game.game.day =  dayList.pop_front()
	if currentDay >= weekLength:
		await Game.game.weekend()
