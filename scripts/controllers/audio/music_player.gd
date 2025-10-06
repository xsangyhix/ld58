extends AudioStreamPlayer2D
class_name MusicPlayer


@export var main_menu_music: AudioStream
@export var level_music: AudioStream


func play_main_menu_music() -> void:
	stream = main_menu_music
	play()
	
func play_level_music() -> void:
	stream = level_music
	play()
