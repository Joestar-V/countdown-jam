extends Node2D
signal finished
const SLOT = preload("res://objects/slot.tscn")
var slot_index = 0
#var slotList : Array[Node2D]
@export var radius := 224.0
@export var spacing_degrees :=21.5
@onready var total_rotation = 0.0
@onready var spinwheel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func rotate_next():
	spinwheel = Game.game.spinwheel
	var target_rotation = deg_to_rad((Game.game.calender.currentDay+1) * spacing_degrees)
	for seed in Game.game.seedList:
		if seed.slotted: #try planted or moving it after the function
			seed.og_parent = seed.get_parent()
			seed.rotato = true
			seed.reparent(self,true)

	create_tween() \
		.tween_property(spinwheel, "rotation", target_rotation, 1) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)
	var tweener = create_tween() \
		.tween_property(self, "rotation", target_rotation, 1) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)
	await tweener.finished
	for seed in Game.game.seedList:
		if seed.slotted: #try planted or moving it after the function
			seed.reparent(seed.og_parent,true)
			seed.rotato = false
	total_rotation = target_rotation
	finished.emit()
	
func reset_rotate():
	
	create_tween() \
		.tween_property(spinwheel, "rotation", 0, 2) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)
	create_tween() \
		.tween_property(self, "rotation", 0, 2) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)
	total_rotation = 0
	#
func create_circle():
	var i = 0 
	for slot in Game.game.slotList:
		var angle = deg_to_rad(-90 + (i-2) * spacing_degrees)
		slot.reparent(self,true)

		slot.position = Vector2(
			cos(angle),
			sin(angle)
		) * radius
		i += 1
		slot.reparent(Game.game.spots,true)
