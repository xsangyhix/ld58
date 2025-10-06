extends Control
class_name DialogueUiController


@export var dialogue_rtl: RichTextLabel
@export var dialogue_container: Control


var _playback_speed: float
var _visible_characters: float = 0
var _is_printing = false
var _timeout_timer: SceneTreeTimer
var _hide_box_delay: float = 0

func _ready() -> void:
	GameEventBus.submit_dialogue.connect(start_text_print)
	_hide_dialogue_box()
	
	
func start_text_print(dialogue_resource: DialogueResource) -> void:
	if is_instance_valid(_timeout_timer):
		_timeout_timer.timeout.disconnect(_hide_dialogue_box)
		
	_show_dialogue_box()
	dialogue_rtl.visible_characters = 0
	dialogue_rtl.text = dialogue_resource.text
	_playback_speed = dialogue_resource.print_speed_c_per_s
	_visible_characters = 0
	_hide_box_delay = dialogue_resource.text_on_screen_delay
	_is_printing = true
	

func _process(delta: float) -> void:
	if _is_printing:
		_add_characters(delta)
	
	if _is_printing and int(_visible_characters) > dialogue_rtl.get_total_character_count():
		_is_printing = false
		GameEventBus.dialogue_finished_print.emit()
		_timeout_timer = get_tree().create_timer(_hide_box_delay)
		_timeout_timer.timeout.connect(_hide_dialogue_box)
		
		
		
func _add_characters(delta: float) -> void:
	_visible_characters += _playback_speed * delta
	dialogue_rtl.visible_characters = int(_visible_characters)


func _show_dialogue_box() -> void:
	dialogue_container.visible = true
	
	
func _hide_dialogue_box() -> void:
	dialogue_rtl.clear()
	dialogue_container.visible = false
