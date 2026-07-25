extends Day


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
func day_start():
	for seed in Game.game.seedList:
		if !seed.slotted:
			seed.water_cost = 0
			seed.update_visuals()
func day_end():
	for seed in Game.game.seedList:
		if !seed.slotted:
			seed.water_cost = seed.OG_water_cost
			seed.update_visuals()
