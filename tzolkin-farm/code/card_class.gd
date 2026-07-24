
extends Node2D
class_name Card
@onready var shop := false
var money_cost := 5
#@onready var sell_value := 4

@onready var move_component = $MoveComponent

@onready var default_scale = Vector2(1.0,1.0)
@onready var hover_scale = Vector2(1.1,1.1)
@onready var hovered = false

@onready var card_image = $visual/card_image
@onready var card_border = $visual/card_border

@export var card_name : String 
@export var picture : Texture 
@export_enum("Dirt Cheap", "Scarce", "One of a Kind") var rarity = 0

@export_multiline var tooltip : String = "this is the tooltip"
@onready var transition_type = Tween.TransitionType.TRANS_SINE


@onready var stat_spread = $visual/stat_spread

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
signal finished
# Called when the node enters the scene tree for the first time.
func _ready():
	seedPacket = load(scene_file_path)
	print(seedPacket)
	scale = default_scale
	update_visuals()
	
	match rarity:
		0: money_cost = 1
		1: money_cost = 2
		2: money_cost = 3

func update_visuals():
	scale = default_scale


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
	if shop:
		
		if Game.game.moneyCount >= money_cost:
			pass
		else:
			modulate= Color(1.0, 1.0, 1.0, 1.0).darkened(0.30)
			
		return
	stat_spread.hide()
	
	if Game.game.water < water_cost and !slotted:
		Game.game.red_text()
	if slotted:
		if !planted:
			dragging = true
			of = get_global_mouse_position() - global_position
	else:
		dragging = true
		of = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
		#maybe entering an area doesnt slot you right away, it just sets a potential slot and when you let go it slots you

	if shop:
		
		if Game.game.moneyCount >= money_cost:
			print("purchase")
			Game.game.moneyCount -= money_cost
			Game.game.seedkeeper.drawpile.add_card(seedPacket)
			
			$visual.hide()
			
			for i in 1:
				var crd = TINY_CARD.instantiate()
				goodies.add_child(crd)
				crd.type = 3
				crd.global_position = global_position
				crd.card = i
				crd.move_to_resource(Game.game.seedkeeper.drawpile.pouch.global_position)
				await get_tree().create_timer(.5).timeout
				
			queue_free()
		else:
			
			#play noise aswell
			modulate= Color(1.0, 1.0, 1.0, 1.0)
		return
	
	stat_spread.show()
	Game.game.white_text()
	dragging = false
	if slotted:
		global_position = slotPos


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "slotHole" and (moving):
		slot = area.get_parent()
		#area.get_parent().seed.append(self)
		slotted = true
		slotPos = area.global_position
		#turn_over.emit()
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


func harvest(foodCount = 0, moneyCount = 0, fertCount = 0, cards = [seedPacket]):
	for i in foodCount:
		var foodlet = TINY_FOOD.instantiate() 
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
	for kid in goodies.get_children():
		if kid:
			await kid.finished
	#var remaining := goodies.get_child_count()
#
	#for kid in goodies.get_children():
		#kid.finished.connect(func():
			#remaining -= 1
		#)
#
	#while remaining > 0:
		#await get_tree().process_frame
	Game.game.water += water_cost
	destroy = true
	finished.emit()


func zoom():
	if hovered == false:
		hovered = true
		stat_spread.show()
		scale = hover_scale
		#create_tween().tween_property(self,"scale",hover_scale,0.2).set_trans(transition_type)
		#await get_tree().create_timer(.2).timeout
	
func unzoom():
	if hovered == true:
		hovered = false
		stat_spread.hide()
		scale = default_scale
		#create_tween().tween_property(self,"scale",default_scale,0.15).set_trans(transition_type)
		#await get_tree().create_timer(.15).timeout

func move_to_resource(dest):
	await get_tree().create_timer(.1).timeout
	move_component.start_moving_time(dest,.3)
