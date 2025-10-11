extends Node
class_name EventBus

signal submit_dialogue(dialogue_resource: DialogueResource)
signal dialogue_print_started()
signal dialogue_print_finished()
signal player_entered_root()
signal scene_started(scene_type: GameEnums.scene_type)



func _ready() -> void:
	submit_dialogue.connect(_dialogue_emitted)


func _dialogue_emitted(dialogue_resource: DialogueResource):
	print("Dialogue emitted! Content: {text}".format({"text": dialogue_resource.text}))
