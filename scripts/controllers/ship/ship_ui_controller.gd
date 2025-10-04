extends Control
class_name ShipUiController


var ship_enter_label: Label

func _ready() -> void:
	ship_enter_label = find_child("ShipEnterIndicator")
	call_deferred("hide_ship_enter_label")


func show_ship_enter_label() -> void:
	ship_enter_label.visible = true
	
	
func hide_ship_enter_label() -> void:
	ship_enter_label.visible = false

func is_ship_etner_label_visible() -> bool:
	return ship_enter_label.visible

func set_ship_enter_label_visibility(input_state: bool) -> void:
	if input_state:
		show_ship_enter_label()
	else:
		hide_ship_enter_label()
