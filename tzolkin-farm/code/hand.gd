extends VBoxContainer

var handList : Array[Card] 
var slotList : Array[TextureRect]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for slot in get_children():
		if slot is TextureRect:
			slotList.append(slot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
