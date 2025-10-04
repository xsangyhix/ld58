class_name State
extends Node


func handle_input(_input_event: InputEvent, _fsm_context: FsmContext):
	pass


func handle_unhandled_input(_input_event: InputEvent, _fsm_context: FsmContext):
	pass	


func update(_delta: float, _fsm_context: FsmContext) -> void:
	pass
	

func physics_update(_delta: float, _fsm_context: FsmContext) -> void:
	pass
	
	
func enter(_fsm_context: FsmContext) -> void:
	pass
	
func exit(_fsm_context: FsmContext) -> void:
	pass
