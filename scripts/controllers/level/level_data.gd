extends Resource
class_name LevelData


@export var player_position: Vector2
@export var ships: Array[ShipData]
@export var level_id: String
@export var is_initialized: bool = false
@export var is_root: bool = false
@export var parent_id: String
@export var ship_type: String


func clean_up_broken_ships() -> LevelData:
	ships = ships.filter(func(x): return not x.is_bottle_broken)
	
	return self
