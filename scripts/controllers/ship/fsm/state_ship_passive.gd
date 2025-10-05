extends State
class_name StateShipPassive


func enter(_fsm_context: FsmContext) -> void:
	_fsm_context.context_memory["is_ship_enter_label_visible"] = false


func update(_delta: float, _fsm_context: FsmContext) -> void:
	if _fsm_context.get_value_bool("player_in_area", false):
		var state_machine: StateMachine = get_parent()
		state_machine.request_state("StateShipActive")

