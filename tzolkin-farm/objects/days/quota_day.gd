extends Day


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func biggify():
	scale = Vector2(1.5,1.5)
	bg.modulate = Color.LIGHT_BLUE

func tinymize():
	scale = Vector2(1.2,1.2)
	bg.modulate = Color.RED
