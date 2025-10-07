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
	if _is_in_title_screen:
		_emit_greeting()
		

	
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

func _get_player() -> PlayerController:
	var player_nodes := get_tree().get_nodes_in_group("player")
	
	if player_nodes.size() == 0:
		push_error("Player not found! Returning null.")
		return null
	
	if player_nodes.size() > 1:
		push_error("More than one player! Returning first one.")
		
	if not player_nodes[0] is PlayerController:
		push_error("Invalid player node type. Returning null.")
		return null
		
	return player_nodes[0]
