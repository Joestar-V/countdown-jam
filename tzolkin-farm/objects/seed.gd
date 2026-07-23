class_name plant
extends Node2D
signal turn_over

var dragging = false
var of = Vector2(0,0)
var slotPos = Vector2(0,0)
var slot 
var slotted = false
var spinning
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() - of
	if spinning:
		position = slot.global_position


func _on_button_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
	dragging = false
	if slotted:
		position = slotPos


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "slotHole" and area.get_parent().open:
		slot = area.get_parent()
		slotted = true
		slotPos = area.global_position
		turn_over.emit()
		


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "slotHole":
		slotted = false
