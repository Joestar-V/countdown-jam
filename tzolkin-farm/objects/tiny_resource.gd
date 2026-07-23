extends Sprite2D
@onready var move_component: MoveComponent = $MoveComponent

var type = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_move_component_movement_finished() -> void:
	match type:
		0:
			Game.game.foodCount += 1
		1: 
			Game.game.moneyCount += 1
		2:
			Game.game.fertCount += 1
	queue_free()
func move_to_resource(dest):
	await get_tree().create_timer(.1).timeout
	move_component.start_moving_time(dest,.3)
