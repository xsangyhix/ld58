extends State
class_name StateShipPassive


func enter(_fsm_context: FsmContext) -> void:
	_fsm_context.context_memory["is_ship_enter_label_visible"] = false


