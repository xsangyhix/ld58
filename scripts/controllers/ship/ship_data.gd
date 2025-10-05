extends Resource
class_name ShipData


@export var ship_position: Vector2
@export var ship_type: String
@export var ship_tier: String
@export var ship_id: String
@export var is_bottle_broken: bool = false


func break_bottle() -> void:
	is_bottle_broken = true

