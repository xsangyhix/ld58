extends State
class_name StateCollectorTalking


@export var animated_sprite: AnimatedSprite2D
@export var collector_audio_controller: CollectorAudioController
@export var word_delay_sec: float = 0.1
@export var repeat_limit: int = 3
@export var pitch_range_min: float = 0.9
@export var pitch_range_max: float = 1.1

var _recently_played: Array[int] = []

func enter(_fsm_context: FsmContext) -> void:
	collector_audio_controller.finished.connect(_start_next_sound)
	GameEventBus.dialogue_print_finished.connect(_on_dialogue_end)
	_start_next_sound()
	_recently_played = []
	
	print("state collector talking ready")
	animated_sprite.set_animation("talking")
	
func exit(_fsm_context: FsmContext) -> void:
	_recently_played = []
	
	collector_audio_controller.finished.disconnect(_start_next_sound)
	GameEventBus.dialogue_print_finished.disconnect(_on_dialogue_end)


func update(_delta: float, _fsm_context: FsmContext) -> void:
	if !RootUi.dialogue_ui_controller.is_finished_printing():
		_on_dialogue_end()


func _start_next_sound() -> void:
	await get_tree().create_timer(word_delay_sec).timeout
	collector_audio_controller.stream = _get_random_track()
	collector_audio_controller.pitch_scale = randf_range(pitch_range_min, pitch_range_max)
	collector_audio_controller.play()
	
	
func _get_random_track() -> AudioStream:
	var tracks: Array[AudioStream] = collector_audio_controller.collector_voice_array
	if _recently_played.size() >= repeat_limit: _recently_played.pop_front()
	var index_range: Array = range(0, tracks.size())
	index_range.filter(func(i): return not i in _recently_played)
	var target_index = index_range.pick_random()
	_recently_played.append(target_index)
	return tracks[target_index]

func _on_dialogue_end() -> void:
	get_parent().request_state("StateCollectorIdle")
