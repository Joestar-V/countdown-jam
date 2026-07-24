




extends Node2D
class_name Card
@onready var card_image: Sprite2D = $card_image
@export var card_name : String 
@export var picture : Texture 
@export_enum("Dirt Cheap", "Scarce", "One of a Kind") var rarity = 0

@export_multiline var tooltip : String = "this is the tooltip"
@onready var transition_type = Tween.TransitionType.TRANS_SINE

const TINY_FERT = preload("res://objects/tiny_fert.tscn")
const TINY_FOOD = preload("res://objects/tiny_food.tscn")
const TINY_MONEY = preload("res://objects/tiny_money.tscn")
const TINY_CARD = preload("res://objects/tiny_card.tscn")

@onready var goodies: Node2D = $Goodies

var destroy = false

signal turn_over

var dragging = false
var of = Vector2(0,0)
var slotPos = Vector2(0,0)
var slot 
var slotted = false
var spinning
var moving = 0
var planted = false
var homeSlot 
var handPos = 0
var seedPacket : PackedScene
@export var water_cost := 1

# Called when the node enters the scene tree for the first time.
func _ready():
	seedPacket = load(scene_file_path)
	print(seedPacket)
	update_visuals()

func update_visuals():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position() - of
	elif !slotted:
		global_position = homeSlot.global_position + Vector2(card_image.texture.get_width() / 6.0 , card_image.texture.get_height() / 6.0)
	if spinning:
		global_position = slot.global_position
	if destroy:
		if !goodies.get_children():
			queue_free()


func _on_button_button_down() -> void:
	if slotted:
		if !planted:
			dragging = true
			of = get_global_mouse_position() - global_position
	else:
		dragging = true
		of = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
	dragging = false
	if slotted:
		global_position = slotPos


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "slotHole" and (moving):
		slot = area.get_parent()
		area.get_parent().seed.append(self)
		slotted = true
		slotPos = area.global_position
		#turn_over.emit()
	elif area.name == "slotHole" and  Game.game.water < water_cost:
		Game.game.red_text()
	elif area.name == "slotHole" and (Game.game.fertCount >= area.get_parent().pos) and (Game.game.water >= water_cost) and !Game.game.harvested:
		if slotted:
			Game.game.fertCount += slot.pos
			Game.game.water += water_cost
		Game.game.water -= water_cost
		Game.game.fertCount -= area.get_parent().pos
		Game.game.actions -= 1
		slot = area.get_parent()
		area.get_parent().seed.append(self)
		slotted = true
		slotPos = area.global_position
		#turn_over.emit()
		


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "slotHole" and moving:
		moving -= 1
	
	elif area.name == "slotHole" and slotted and slot == area.get_parent():
		Game.game.fertCount += slot.pos
		Game.game.water += water_cost

		slotted = false
		slot = null
		area.get_parent().seed.erase(self)
		Game.game.actions += 1
	elif area.name == "slotHole" and !slotted:
		Game.game.white_text()


func harvest(foodCount = 0, moneyCount = 0, fertCount = 0, cards = [seedPacket]):
	for i in foodCount:
		var foodlet = TINY_FOOD.instantiate() #why does only 1 apple spawn?
		goodies.add_child(foodlet)
		foodlet.global_position = global_position
		foodlet.type = 0
		foodlet.move_to_resource(Game.game.resources.food.global_position)
		await get_tree().create_timer(.1).timeout

	for i in moneyCount:
		var foodlet = TINY_MONEY.instantiate()
		goodies.add_child(foodlet)
		foodlet.type = 1
		foodlet.global_position = global_position
		foodlet.move_to_resource(Game.game.resources.money_bag.global_position)
		await get_tree().create_timer(.1).timeout

	for i in fertCount:
		var foodlet = TINY_FERT.instantiate()
		goodies.add_child(foodlet)
		foodlet.type = 2
		foodlet.global_position = global_position
		foodlet.move_to_resource(Game.game.resources.fertilizer.global_position)
		await get_tree().create_timer(.1).timeout
	for i in cards:
		var foodlet = TINY_CARD.instantiate()
		goodies.add_child(foodlet)
		foodlet.type = 3
		foodlet.global_position = global_position
		foodlet.card = i
		foodlet.move_to_resource(Game.game.seedkeeper.discard_pile.recycle_bin.global_position)
		await get_tree().create_timer(.1).timeout
	Game.game.water += water_cost
	destroy = true

func zoom():
	create_tween().tween_property(self,"scale",Vector2(0.53,0.53),0.2).set_trans(transition_type)
	
func unzoom():
	create_tween().tween_property(self,"scale",Vector2(0.5,0.5),0.15).set_trans(transition_type)
