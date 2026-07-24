class_name MoveComponent
extends Node

@export var actor : Node2D
@export var target_destination : Vector2
@export var move_speed : int
@export var weight : float
@export var moving = false
@export var lerp = false
#@onready var skin = $"../Skin"

var start_pos: Vector2
var duration: float
var elapsed := 0.0
var use_time := false

signal movement_finished()

func _process(delta):
	if moving :
		if use_time:
			elapsed += delta
			var t = clamp(elapsed / duration, 0.0, 1.0)
			actor.global_position = start_pos.lerp(target_destination, t)
			
			if t >= 1.0:
				moving = false
				use_time = false
				emit_signal("movement_finished")
		else:
			move_to(delta, target_destination)
			move_to_lerp(delta, target_destination)
	
	
func move_to(delta, destination):
	if moving && !lerp:
		actor.global_position = actor.global_position.move_toward(destination, delta*move_speed)
	elif  actor.global_position == destination :
			moving = false
			emit_signal("movement_finished")
			

func move_to_lerp(delta, destination):
	if moving && lerp:
		actor.global_position = lerp(actor.global_position, destination, 0.1)
	elif  actor.global_position == destination :
			moving = false
			lerp = false
			#skin.moving = false
			emit_signal("movement_finished")
			
func start_moving_time(destination: Vector2, time: float):
	start_pos = actor.global_position
	target_destination = destination
	duration = time
	elapsed = 0.0
	moving = true
	use_time = true
