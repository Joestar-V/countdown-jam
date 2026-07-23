extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D

const SLOT = preload("res://objects/slot.tscn")
var slot_index = 0
var slotList : Array[Node2D]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var top_y = global_position.y - (sprite_2d.texture.get_height() * sprite_2d.global_scale.y / 2.0)
	for i in 7:
		var slot = SLOT.instantiate()
		add_child(slot)
		slotList.append(slot)
		slot.position.y = top_y
		print(slot.position)
		slot.rotation = -30 + i*10
		print(slot.rotation)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
