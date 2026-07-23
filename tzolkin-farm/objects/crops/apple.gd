extends Seed


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func on_harvest_sprout():
	harvest(0,0,1,[seedPacket]) 

func on_harvest_flower():
	harvest(0,3,0,[seedPacket]) 

func on_harvest_fruit():
	harvest(5,4,3,[seedPacket]) 
