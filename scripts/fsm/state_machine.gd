class_name StateMachine
extends Node


signal transitioned_state(state_name: State)

@export var initial_state: State

var current_state: State
var fsm_context: FsmContext = FsmContext.new()
var states: Dictionary[String, State]

var _next_state: State


func _ready() -> void:

	if initial_state == null:
		for child_node in get_children():
			if child_node is State:
				initial_state = child_node
				break
				
	if initial_state == null:
		push_error("State machine requires at least one state!")
		get_tree().quit()	

	current_state = initial_state

	for child_node in get_children():
		if child_node is State:
			states[child_node.name] = child_node
			
	current_state.enter(fsm_context)
			


func _process(_delta: float) -> void:
	_process_current_state(_delta)
	
	_process_transitions()
	
func _physics_process(_delta: float) -> void:
	if _is_current_state_invalid(): return

	current_state.physics_update(_delta, fsm_context)
	
func _input(event: InputEvent) -> void:
	if _is_current_state_invalid(): return
	
	current_state.handle_input(event, fsm_context)
	
func _unhandled_input(event: InputEvent) -> void:
	if _is_current_state_invalid(): return
	
	current_state.handle_unhandled_input(event, fsm_context)
	
func transition_state(new_state_name: String) -> void:
	if not states.has(new_state_name):
		push_error("${new_state_name} state does not exist in fsm! Transition skipped.")
		return

	current_state.exit(fsm_context)
	current_state = states[new_state_name]
	current_state.enter(fsm_context)
	transitioned_state.emit(current_state)

func request_state(next_state_name: String):
	if not states.has(next_state_name):
		push_error("Target state ${new_state_name} does not exist in fsm! Request ignored.")
		return
		
	if not is_instance_valid(states[next_state_name]):
		push_error("State ${next_state_name} is invalid! Requet ignored.")
		return
	
	_next_state = states[next_state_name]
	
	

func _is_current_state_valid() -> bool:
	if is_instance_valid(current_state):
		return true
	else:
		return false

func _is_current_state_invalid() -> bool:
	return not _is_current_state_valid()
	
func _process_current_state(_delta: float) -> void:
	if _is_current_state_invalid(): return
		
	current_state.update(_delta, fsm_context)

func _process_transitions() -> void:
	if _is_current_state_invalid(): return
	if not is_instance_valid(_next_state): return

	if current_state != _next_state:
		transition_state(_next_state.name)
		_next_state = null
