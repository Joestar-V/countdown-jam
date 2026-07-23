extends Node2D
class_name Card

@export var card_name : String 
@export var picture : Texture 
@export_enum("Dirt Cheap", "Scarce", "One of a Kind") var rarity = 0

@export_multiline var tooltip : String = "this is the tooltip"

const TINY_FERT = preload("res://objects/tiny_fert.tscn")
const TINY_FOOD = preload("res://objects/tiny_food.tscn")
const TINY_MONEY = preload("res://objects/tiny_money.tscn")
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
# Called when the node enters the scene tree for the first time.
func _ready():
	update_visuals()

func update_visuals():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() - of
	if spinning:
		position = slot.global_position
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
		position = slotPos


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "slotHole" and (moving):
		slot = area.get_parent()
		area.get_parent().seed = self
		slotted = true
		slotPos = area.global_position
		#turn_over.emit()
	elif area.name == "slotHole" and (Game.game.fertCount >= area.get_parent().pos):
		if slotted:
			Game.game.fertCount += slot.pos

		Game.game.fertCount -= area.get_parent().pos
		Game.game.actions -= 1
		slot = area.get_parent()
		area.get_parent().seed = self
		slotted = true
		slotPos = area.global_position
		#turn_over.emit()
		


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "slotHole" and moving:
		moving -= 1
	elif area.name == "slotHole" and slotted and slot == area.get_parent():
		Game.game.fertCount += slot.pos

		slotted = false
		slot = null
		area.get_parent().seed = null
		Game.game.actions += 1



func harvest(foodCount = 0, moneyCount = 0, fertCount = 0, cards = []):
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

	destroy = true
