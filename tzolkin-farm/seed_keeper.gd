extends Node2D

@onready var drawpile: Node2D = $Drawpile
@onready var hand: VBoxContainer = $Hand
@onready var handsize = 3
@onready var discard_pile: Node2D = $DiscardPile
const TINY_CARD = preload("res://objects/tiny_card.tscn")
signal finish_sorting
@onready var remaining = 0

#card thats better when planted with more of itself
#card that is good to harvest as a sprout but it doenst give back a seed when it does
#sunflowers are advantageous at all parts of their life

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_kid_finished():
	remaining -= 1
	
func draw_until_full(): 
	var j = -1
	for i in hand.handList:
		j += 1
		if i and i != null:
			pass
		else:
			if drawpile.pile.is_empty():
				await reshuffle()
			if drawpile.pile.is_empty():
				finish_sorting.emit()
				return
			var drawnCard = drawpile.pile.front().instantiate()
			drawpile.pile.pop_front()
			drawpile.draw_count.text = str(drawpile.pile.size())
			hand.handList[j] = (drawnCard)
			hand.add_child(drawnCard)
			drawnCard.handPos = j
			drawnCard.homeSlot = hand.slotList[j]
			Game.game.seedList.append(drawnCard)
			for bld in Game.game.building_keeper.buildings: bld.on_seed_init(drawnCard)
	
	
			
func reshuffle():
	var tinyList : Array
	var notfinished = true
	discard_pile.pile.shuffle()
	while !discard_pile.pile.is_empty():
		print(discard_pile.pile.front())
		var card = discard_pile.pile.pop_front()
		print(card)
		var tinycard = TINY_CARD.instantiate()
		tinyList.append(tinycard)
		add_child(tinycard)

		tinycard.card = card
		tinycard.type = 3
		remaining += 1
		tinycard.finished.connect(_on_kid_finished, CONNECT_ONE_SHOT)
		discard_pile.discard_count.text = str(discard_pile.pile.size())

		tinycard.animation_player.play("tiny_resource/recycle")
		await get_tree().create_timer(0.1).timeout
	
	while remaining > 0:
		await get_tree().process_frame
