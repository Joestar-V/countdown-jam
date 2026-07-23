extends Node2D

@onready var seedList : Array
@onready var seedpouch: Node2D = $Seedpouch

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for seed in seedpouch.get_children():
		seedList.append(seed)
		seed.turn_over.connect(_on_seed_turn_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_seed_turn_over() -> void:
	for seed in seedList:
		if seed.slotted:
			seed.spinning = false
