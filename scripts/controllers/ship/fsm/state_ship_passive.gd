extends State
class_name StateShipPassive


@export var bottled_ship_controller: BottledShip


func enter(_fsm_context: FsmContext) -> void:
	bottled_ship_controller.ship_ui_controller.set_ship_label_visibility(false)


func update(_delta: float, _fsm_context: FsmContext) -> void:
	if _fsm_context.get_value_bool("player_in_area", false):
		var state_machine: StateMachine = get_parent()
		state_machine.request_state("StateShipActive")
