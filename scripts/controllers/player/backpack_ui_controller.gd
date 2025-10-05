extends Control
class_name BackpackUiController

@export var ship_count_label: Label

var _ship_count: int = 0


func add_ship() -> void:
	_ship_count += 1
	_update_label()
	
func set_ship_count(ship_count: int) -> void:

	_ship_count = ship_count
	
	if _ship_count < 0: _ship_count = 0
	
	_update_label()
	
	
func _update_label() -> void:
	ship_count_label.text = "Ship count: {count}".format({"count": _ship_count})
