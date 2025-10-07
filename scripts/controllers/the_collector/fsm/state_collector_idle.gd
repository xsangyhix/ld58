extends State
class_name StateCollectorIdle


@export var animated_sprite: AnimatedSprite2D


func enter(_fsm_context: FsmContext) -> void:
	GameEventBus.start_dialogue.connect(_on_dialogue_start)
	animated_sprite.set_animation("idle")
	
func exit(_fsm_context: FsmContext) -> void:
	GameEventBus.start_dialogue.disconnect(_on_dialogue_start)

func _on_dialogue_start() -> void:
	get_parent().request_state("StateCollectorTalking")
