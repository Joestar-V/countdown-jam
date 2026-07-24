extends Sprite2D
@onready var move_component: MoveComponent = $MoveComponent
signal finished
var type = 0
var card 
var value = 1:
	set(val):
		value = val
		scale = Vector2(scale.x * value,scale.y * value)
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func update_pic(cardPic):
	texture = cardPic

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_move_component_movement_finished(targ = 0) -> void:
	
	match type:
		0:
			Game.game.foodCount += value
		1: 
			Game.game.moneyCount += value
		2:
			Game.game.fertCount += value
		3:
			match targ:
				0:
					Game.game.seedkeeper.discard_pile.add_card(card)
				1:
					Game.game.seedkeeper.drawpile.add_card(card)
	finished.emit()

	queue_free()

	
	
func move_to_resource(dest):
	await get_tree().create_timer(.1).timeout
	move_component.start_moving_time(dest,.3)
