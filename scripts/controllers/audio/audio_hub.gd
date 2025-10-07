extends AudioStreamPlayer2D
class_name AudioHub

@export var music_player: MusicPlayer

@export var bottle_open_sfx: AudioStream
@export var bottle_exit_sfx: AudioStream
@export var collect_bottle_sfx: AudioStream
@export var break_bottle_sfx: AudioStream
@export var jump_sfx: AudioStream
@export var land_sfx: AudioStream
@export var game_start_sound_sfx: AudioStream
@export var ui_ding_sfx: AudioStream
@export var damage_sfx: AudioStream

func play_bottle_open() -> void:
	_play_temp_sfx(bottle_open_sfx)

func play_bottle_exit() -> void:
	_play_temp_sfx(bottle_exit_sfx)
	
func play_collect_bottle() -> void:
	_play_temp_sfx(collect_bottle_sfx)

func play_break_bottle() -> void:
	_play_temp_sfx(break_bottle_sfx)

func play_jump() -> void:
	_play_temp_sfx(jump_sfx)

func play_land() -> void:
	_play_temp_sfx(land_sfx)

func play_game_start_sound() -> void:
	_play_temp_sfx(game_start_sound_sfx)

func play_ui_ding() -> void:
	_play_temp_sfx(ui_ding_sfx)

func play_damage() -> void:
	_play_temp_sfx(damage_sfx)


func play_main_menu_music() -> void:
	music_player.play_main_menu_music()

func play_level_music() -> void:
	music_player.play_level_music()
	


func _play_temp_sfx(sfx: AudioStream) -> void:
	if sfx == null:
		return
	var p := AudioStreamPlayer.new()
	p.stream = sfx
	p.bus = bus
	add_child(p)
	p.finished.connect(p.queue_free)
	p.play()
