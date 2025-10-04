extends Node
class_name StateMachine


signal transitioned_state(state_name: State)

@export var initial_state: State

var current_state: State
var fsm_context: FsmContext
var states: Dictionary[String, State]


func _ready() -> void:

	if initial_state == null:
		for child_node in get_children():
			if child_node is State:
				initial_state = child_node
				
	if initial_state == null:
		push_error("State machine requires at least one state!")
		get_tree().quit()	

	for child_node in get_children():
		if child_node is State:
			states[child_node.name] = child_node
			

func _process(_delta: float) -> void:
	if not is_instance_valid(current_state):
		return
		
	current_state.update(_delta, fsm_context)
	
func _physics_process(_delta: float) -> void:
	if not is_instance_valid(current_state):
		return

	current_state.physics_update(_delta, fsm_context)
	
func transition_state(new_state_name: String) -> void:
	if not states.has(new_state_name):
		push_error("${new_state_name} state does not exist in fsm! Transition skipped.")
		return	

	current_state.exit(fsm_context)
	current_state = states[new_state_name]
	current_state.enter(fsm_context)
	transitioned_state.emit(current_state)
