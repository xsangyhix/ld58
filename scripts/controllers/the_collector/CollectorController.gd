extends Node2D
class_name CollectorController


@export var audio_controller: CollectorAudioController
@export var collector_state_machine: StateMachine


@export var text_greetings: Array[DialogueResource] = []


func _ready() -> void:
	call_deferred("_emit_greeting")
	
func _emit_greeting() -> void:
	GameEventBus.submit_dialogue.emit(text_greetings.pick_random())
