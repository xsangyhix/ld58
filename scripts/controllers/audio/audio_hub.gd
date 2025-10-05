extends AudioStreamPlayer2D
class_name AudioHub


@export var bottle_open_sfx: AudioStream
@export var bottle_exit_sfx: AudioStream
@export var collect_bottle_sfx: AudioStream

func play_bottle_open() -> void:
	stream = bottle_open_sfx
	play()

func play_bottle_exit() -> void:
	stream = bottle_exit_sfx
	play()
	
func play_collect_bottle() -> void:
	stream = collect_bottle_sfx
	play()
