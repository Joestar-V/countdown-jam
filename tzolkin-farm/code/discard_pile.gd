extends Node2D

var pile : Array[PackedScene]
@onready var recycle_bin: Sprite2D = $RecycleBin
@onready var discard_count: Label = $discard_count

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	discard_count.text = str(pile.size())



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func add_card(cardScene):
	pile.append(cardScene)
	discard_count.text = str(pile.size())
