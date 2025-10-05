extends State
class_name StateShipBreak


func enter(_fsm_context: FsmContext) -> void:
	_fsm_context.context_memory["break"] = true
	_fsm_context.context_memory["is_ship_enter_label_visible"] = false
	
	trigger_remove_after_delay(10, _fsm_context)

func trigger_remove_after_delay(delay: float, fsm_context: FsmContext) -> void:
	await get_tree().create_timer(delay).timeout
	fsm_context.context_memory["remove"] = true	
