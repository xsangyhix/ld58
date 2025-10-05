extends Control
class_name ShipUiController


@export var ship_enter_label: Label
@export var ship_collect_label: Label

func _ready() -> void:
	call_deferred("hide_ship_labels")


func show_ship_labels() -> void:
	ship_enter_label.visible = true
	ship_collect_label.visible = true
	
	
func hide_ship_labels() -> void:
	ship_enter_label.visible = false
	ship_collect_label.visible = false

func is_ship_label_visible() -> bool:
	return ship_enter_label.visible

func set_ship_label_visibility(input_state: bool) -> void:
	if input_state:
		show_ship_labels()
	else:
		hide_ship_labels()
