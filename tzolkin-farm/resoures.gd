extends Node2D
@onready var fertilizer: Sprite2D = $Fertilizer
@onready var food: Sprite2D = $Food
@onready var money_bag: Sprite2D = $MoneyBag
@onready var money_label: Label = $moneyLabel
@onready var food_label: Label = $foodLabel
@onready var fertilizer_label: Label = $fertilizerLabel
@onready var quota_label: Label = $foodLabel2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update_quota(quote):
	quota_label.text = str(quote)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
