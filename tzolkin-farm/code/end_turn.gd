extends Button


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("End Turn") and !disabled:
		for seed in Game.game.seedkeeper.hand.get_children():
			if seed.has_method("unzoom"):
				seed.unzoom()
		emit_signal("pressed")
		
