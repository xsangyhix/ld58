extends LevelController
class_name ShipLevelController



var parent_id: String
var ship_type: String
var audio_hub: AudioHub
var ship_tier: String

func _ready() -> void:
	audio_hub = get_node("/root/MainAudioHub")
	var level_data: LevelData = LevelLoader.load_current_level()
	
	if level_data.is_initialized:
		_assign_ids(level_data)
		_regenerate_assets(level_data)
	else:
		_assign_ids(level_data)
		_assign_root_ids_to_ships()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit_ship"):
		mark_bottle_to_destroy()
		exit_to_parent()

	
func exit_to_parent() -> void:
	serialize_level()
	
	audio_hub.play_bottle_exit()
	
	var parent_level_data: LevelData = LevelLoader.load_level(parent_id)
	LevelLoader.set_level_as_current(parent_level_data.level_id)
	var parent_level_packed_scene = PrefabLoader.load_level(parent_level_data)
	get_tree().change_scene_to_packed(parent_level_packed_scene)


func mark_bottle_to_destroy() -> void:
	var parent_level_data: LevelData = LevelLoader.load_level(parent_id)
	
	var ship_data_array: Array[ShipData] = []
	
	for ship_data in parent_level_data.ships:
		if ship_data.ship_id == get_level_id():
			ship_data.break_bottle()
					
		ship_data_array.append(ship_data)
		
	parent_level_data.ships = ship_data_array
	
	LevelLoader.save_level(parent_level_data)
		
	

	
func serialize_level() -> void:
	var level_data: LevelData = _generate_level_data()
	LevelLoader.save_level(level_data)
	_get_player().serialize_player()
	
	
func _assign_ids(level_data: LevelData) -> void:
	level_id = level_data.level_id
	parent_id = level_data.parent_id
	ship_type = level_data.ship_type
	ship_tier = level_data.ship_tier

func _generate_level_data() -> LevelData:
	var level_data: LevelData = LevelData.new()
	
	level_data.level_id = level_id
	level_data.parent_id = parent_id
	
	level_data.player_position = _get_player().position
	var ships: Array[ShipData] = []
	
	for ship in _get_ships():
		if not ship is BottledShip: continue
		
		ships.append(ship.generate_ship_data())	
	
	level_data.ships = ships
	
	level_data.is_initialized = true
	level_data.ship_type = ship_type
	level_data.ship_tier = ship_tier
	
	return level_data
	
