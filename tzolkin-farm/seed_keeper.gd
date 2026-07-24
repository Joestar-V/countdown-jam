extends Node2D

@onready var drawpile: Node2D = $Drawpile
@onready var hand: VBoxContainer = $Hand
@onready var handsize = 3
@onready var discard_pile: Node2D = $DiscardPile

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
				reshuffle()
			var drawnCard = drawpile.pile.front().instantiate()
			drawpile.pile.pop_front()
			hand.handList[j] = (drawnCard)
			hand.add_child(drawnCard)
			drawnCard.handPos = j
			drawnCard.homeSlot = hand.slotList[j]
			Game.game.seedList.append(drawnCard)
			
func reshuffle():
	discard_pile.pile.shuffle()
	#for i in discard_pile.pile:
		
