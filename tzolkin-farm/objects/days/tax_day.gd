extends Day


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func plant(seed : Seed):
	if seed.slotted:
		seed.mults *= Vector3(1,.5,1)
		seed.slot.update_display()

func day_start():
	for seed in Game.game.seedList:
		if seed.slotted:
			seed.mults *= Vector3(1,.5,1)
			seed.slot.update_display()
			
func day_end():
	for seed in Game.game.seedList:
		if seed.slotted:
			seed.mults *= Vector3(1,2,1)
			seed.slot.update_display()
