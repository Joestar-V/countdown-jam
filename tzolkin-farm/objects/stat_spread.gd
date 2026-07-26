extends PanelContainer

const COIN_ICON = preload("uid://cgknl3qcs48vw")
const FOOD_ICON = preload("uid://c668e1veyatay")
const FERT_ICON = preload("uid://c8yq733xmh0cc")


const BONUS_COIN = preload("uid://ctjcjrrw23c5v")
const BONUS_FERTIL = preload("uid://7ohukfd6rqda")
const BONUS_FOOD = preload("uid://3du4b373wpkw")

var seed : Seed

var icon_list := []

@onready var row_1 = $margin/vbox/row1
@onready var hs_1 = $margin/vbox/HS1
@onready var row_2 = $margin/vbox/row2
@onready var hs_2 = $margin/vbox/HS2
@onready var row_3 = $margin/vbox/row3
@onready var hs_3 = $margin/vbox/HS3
@onready var row_4 = $margin/vbox/row4


func set_visuals():
	
	for icon in icon_list: if icon: icon.queue_free()
		
	
	if seed.sprout != Vector3i(0,0,0):
		row_1.show()
		add_icons(seed.sprout,row_1)
		add_icons(seed.bonus,row_1,true)
	if seed.flower != Vector3i(0,0,0):
		row_2.show()
		add_icons(seed.flower,row_2)
		add_icons(seed.bonus,row_2,true)
	if seed.fruit != Vector3i(0,0,0):
		row_3.show()
		add_icons(seed.fruit,row_3)
		add_icons(seed.bonus,row_3,true)
	if seed.death != Vector3i(0,0,0):
		row_4.show()
		add_icons(seed.death,row_4)
		add_icons(seed.bonus,row_4,true)
	
	
	

func add_icons(spread: Vector3i,target ,  bonus = false):
	for x in spread.x:
		var food = TextureRect.new()
		if bonus : food.texture = BONUS_FOOD
		else : food.texture = FOOD_ICON
		food.expand_mode = 3
		food.stretch_mode = 5
		target.add_child(food)
		icon_list.append(food)
	for y in spread.y:
		var coin = TextureRect.new()
		if bonus : coin.texture = BONUS_COIN
		else : coin.texture = COIN_ICON

		coin.expand_mode = 3
		coin.stretch_mode = 5
		target.add_child(coin)
		icon_list.append(coin)
	for z in spread.z:
		var fert = TextureRect.new()
		if bonus : fert.texture = BONUS_FERTIL
		else : fert.texture = FERT_ICON
		#fert.texture = FERT_ICON
		fert.expand_mode = 3
		fert.stretch_mode = 5
		target.add_child(fert)
		icon_list.append(fert)
