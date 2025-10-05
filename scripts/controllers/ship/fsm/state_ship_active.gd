extends State
class_name StateShipActive

func handle_input(_input_event: InputEvent, _fsm_context: FsmContext):
	if _input_event.is_action_pressed("enter_ship"):
		_fsm_context.context_memory["load_ship"] = true
	
func enter(_fsm_context: FsmContext) -> void:
	_fsm_context.context_memory["is_ship_enter_label_visible"] = true
	
func update(_delta: float, _fsm_context: FsmContext) -> void:
	if not _fsm_context.get_value_bool("player_in_area", false):
		var state_machine: StateMachine = get_parent()
		state_machine.request_state("StateShipPassive")

