extends Day


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	
func day_start():
	Game.game.frozen = true
