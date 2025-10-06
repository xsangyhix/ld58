extends State
class_name StateCollectorIdle

func enter(_fsm_context: FsmContext) -> void:
	GameEventBus.submit_dialogue.connect(_on_dialogue_start)
	
func exit(_fsm_context: FsmContext) -> void:
	GameEventBus.submit_dialogue.disconnect(_on_dialogue_start)

func _on_dialogue_start(_dialogue_resource: DialogueResource) -> void:
	get_parent().request_state("StateCollectorTalking")
