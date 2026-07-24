extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("End Turn"):
		emit_signal("pressed")
		for seed in Game.game.seedkeeper.hand.get_children():
			if seed.has_method("unzoom"):
				seed.unzoom()
	#if Game.game.actions == 0:
		#pass #this is when it starts glowings
	#else:
