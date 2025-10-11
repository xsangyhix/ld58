extends Node2D
class_name CollectorController


@export var audio_controller: CollectorAudioController
@export var collector_state_machine: StateMachine


@export var text_greetings: Array[DialogueResource] = []
@export var text_taunt: Array[DialogueResource] = []
@export var text_intro: Array[DialogueResource] = []
@export var text_end_game: DialogueResource
@export var _is_in_title_screen: bool = false


func _ready() -> void:
	GameEventBus.player_entered_root.connect(_emit_dialogue)
	GameEventBus.submit_dialogue.connect(_print_dialogue)
	if _is_in_title_screen:
		_emit_greeting.call_deferred()
		

	
func _emit_dialogue(player: PlayerController):
	var number_of_entries: int = player.times_entered_root	
	
	if number_of_entries <= 1:
		_emit_tutorial()
		return
		
	if number_of_entries > 1 and player._collected_ships.size() < 100:
		_emit_taunt()
		return
	
	if number_of_entries > 1 and player._collected_ships.size() >= 100:
		_emit_end_game()
		return
		
func _emit_tutorial() -> void:
	for dialogue_data in text_intro:
		GameEventBus.submit_dialogue.emit(dialogue_data)
	
func _emit_taunt() -> void:
	GameEventBus.submit_dialogue.emit(text_taunt.pick_random())
	
func _emit_end_game() -> void:
	for dialogue_data in text_end_game:
		GameEventBus.submit_dialogue.emit(dialogue_data)
	
func _emit_greeting() -> void:
	GameEventBus.submit_dialogue.emit(text_greetings.pick_random())


func _print_dialogue(dialogue_resource: DialogueResource) -> void:
	RootUi.dialogue_ui_controller.submit_dialogue(dialogue_resource)
