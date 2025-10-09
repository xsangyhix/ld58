extends State
class_name StateShipActive


@export var bottled_ship_controller: BottledShip


func handle_input(_input_event: InputEvent, _fsm_context: FsmContext):
	if _input_event.is_action_pressed("enter_ship"):
		_fsm_context.context_memory["load_ship"] = true
		
	if _input_event.is_action_pressed("collect_ship"):
		_fsm_context.context_memory["collect_ship"] = true
	
func enter(_fsm_context: FsmContext) -> void:
	bottled_ship_controller.ship_ui_controller.set_ship_label_visibility(true)
	
func update(_delta: float, _fsm_context: FsmContext) -> void:
	if not _fsm_context.get_value_bool("player_in_area", false):
		var state_machine: StateMachine = get_parent()
		state_machine.request_state("StateShipPassive")

