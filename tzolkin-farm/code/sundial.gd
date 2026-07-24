extends Marker2D
@onready var number: Label = $number
@export var weekLength = 7

@export var currentDay = 0:
	set(value):
		currentDay = value
		number.text = str(weekLength - currentDay)
@export var week = 0
@export var finalDay = 35
@onready var dayList : Array[Day]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func restart():
	currentDay = 0
	#remake day list
func advance_day():
	currentDay += 1
	if currentDay >= weekLength:
		Game.game.weekend()
