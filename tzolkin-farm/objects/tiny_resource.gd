extends Sprite2D
@onready var move_component: MoveComponent = $MoveComponent
signal finished
var type = 0
var card 
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_move_component_movement_finished(targ = 0) -> void:
	match type:
		0:
			Game.game.foodCount += 1
		1: 
			Game.game.moneyCount += 1
		2:
			Game.game.fertCount += 1
		3:
			match targ:
				0:
					Game.game.seedkeeper.discard_pile.add_card(card)
				1:
					Game.game.seedkeeper.drawpile.add_card(card)
	queue_free()
	finished.emit()

	
	
func move_to_resource(dest):
	await get_tree().create_timer(.1).timeout
	move_component.start_moving_time(dest,.3)
