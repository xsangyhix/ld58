extends Control
class_name PlayerUiController


@export var health_controller: HealthUiController
@export var backpack_controller: BackpackUiController


func get_player_hp() -> int:
	return health_controller.get_hp()
	
func set_player_hp(target_hp: int) -> void:
	health_controller.set_hp(target_hp)
	
func add_ship() -> void:
	backpack_controller.add_ship()
	
func set_ship_count(target_ship_count: int) -> void:
	backpack_controller.set_ship_count(target_ship_count)
