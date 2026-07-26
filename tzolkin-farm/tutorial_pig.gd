extends Node2D

@onready var speech_bubble = $SpeechBubble
@onready var tab_container = $TabContainer
@onready var pig = $pig
var shown = true
@onready var click_me = $"pig/click me!"
@onready var darknes = $darknes

@onready var last_state = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#open()


func open():
	if Game.game: last_state = Game.game.current_state
	Game.game.current_state = Game.game.STATE.POPUP
	
	shown = true
	speech_bubble.show()
	tab_container.show()
	click_me.show()
	darknes.show()
	create_tween().tween_property(pig,"position",Vector2(-160.299,-134.0),0.5).set_trans(Tween.TRANS_SINE)
	
func close():
	if last_state != null: Game.game.current_state = last_state
	
	shown = false
	speech_bubble.hide()
	tab_container.hide()
	click_me.hide()
	darknes.hide()
	create_tween().tween_property(pig,"position",Vector2(-80,-134.0),0.5).set_trans(Tween.TRANS_SINE)


func _on_pig_pressed():
	if shown: close()
	else: open()
