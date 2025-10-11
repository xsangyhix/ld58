extends Control
class_name DialogueUiController


@export var dialogue_rtl: RichTextLabel
@export var dialogue_container: Control


var _playback_speed: float
var _visible_characters: float = 0
var _is_printing: bool = false
var _timeout_timer: SceneTreeTimer
var _hide_box_delay: float = 0
var _queue: Array[DialogueResource] = []

func _ready() -> void:
	_hide_dialogue_box()


func submit_dialogue(dialogue_resource: DialogueResource) -> void:
	if is_busy():
		_queue.push_back(dialogue_resource)
		return
	_begin_dialogue(dialogue_resource)
	

func _begin_dialogue(dialogue_resource: DialogueResource) -> void:
	if is_instance_valid(_timeout_timer):
		_timeout_timer.timeout.disconnect(_hide_dialogue_box)
	_show_dialogue_box()
	dialogue_rtl.visible_characters = 0
	dialogue_rtl.text = dialogue_resource.text
	_playback_speed = dialogue_resource.print_speed_c_per_s
	_visible_characters = 0
	_hide_box_delay = dialogue_resource.text_on_screen_delay
	_is_printing = true
	GameEventBus.dialogue_print_started.emit()
	
	print("dialogue started")
	

func _process(delta: float) -> void:
	if _is_printing:
		_add_characters(delta * _playback_speed)
	
	if _is_printing and int(_visible_characters) > dialogue_rtl.get_total_character_count():
		_is_printing = false
		GameEventBus.dialogue_print_finished.emit()
		_timeout_timer = get_tree().create_timer(_hide_box_delay)
		_timeout_timer.timeout.connect(_hide_dialogue_box)
		print("dialogue ended")
		
		
		
		
func _add_characters(delta_characters: float) -> void:
	_visible_characters += delta_characters
	dialogue_rtl.visible_characters = int(_visible_characters)


func _show_dialogue_box() -> void:
	print("showing box")
	dialogue_container.visible = true
	
	
func _hide_dialogue_box() -> void:
	print("hiding box")
	dialogue_rtl.clear()
	_visible_characters = 0
	dialogue_container.visible = false
	# If there are queued dialogues, start the next one immediately
	if _queue.size() > 0:
		var next: DialogueResource = _queue.pop_front()
		_begin_dialogue(next)
	

func is_busy() -> bool: return dialogue_container.visible
	
	
func is_finished_printing() -> bool: return _is_printing
	

func clear_dialogue() -> void:
	# Hard stop any ongoing dialogue and clear UI without triggering queued items.
	_is_printing = false
	if is_instance_valid(_timeout_timer):
		# Ensure pending timeout won't fire hide callback after scene change
		if _timeout_timer.timeout.is_connected(_hide_dialogue_box):
			_timeout_timer.timeout.disconnect(_hide_dialogue_box)
		_timeout_timer = null
	
	# Clear any queued dialogues so nothing starts after scene change
	_queue.clear()
	
	# Hide dialogue box
	_hide_dialogue_box()
