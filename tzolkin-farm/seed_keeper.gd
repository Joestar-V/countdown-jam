extends Node2D

@onready var drawpile: Node2D = $Drawpile
@onready var hand: VBoxContainer = $Hand
@onready var handsize = 3
@onready var discard_pile: Node2D = $DiscardPile
const TINY_CARD = preload("res://objects/tiny_card.tscn")
signal finish_sorting
#card thats better when planted with more of itself
#card that is good to harvest as a sprout but it doenst give back a seed when it does
#sunflowers are advantageous at all parts of their life


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
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
				return
			var drawnCard = drawpile.pile.front().instantiate()
			drawpile.pile.pop_front()
			drawpile.draw_count.text = str(drawpile.pile.size())
			hand.handList[j] = (drawnCard)
			hand.add_child(drawnCard)
			drawnCard.handPos = j
			drawnCard.homeSlot = hand.slotList[j]
			Game.game.seedList.append(drawnCard)
			
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

		discard_pile.discard_count.text = str(discard_pile.pile.size())

		tinycard.animation_player.play("tiny_resource/recycle")
		await get_tree().create_timer(0.1).timeout
	
	for tiny in tinyList:
		if tiny:
			await tiny.animation_player.animation_finished
