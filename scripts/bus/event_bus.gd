extends Node
class_name EventBus

signal submit_dialogue(dialogue_resource: DialogueResource)
signal dialogue_finished_print()
signal player_entered_root()
signal start_dialogue()
signal scene_started(scene_type: GameEnums.scene_type)
