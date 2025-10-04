extends LevelController
class_name ShipLevelController



var parent_id: String
var ship_type: String


func _ready() -> void:
	var level_data: LevelData = LevelLoader.load_current_level()
	print(level_data.is_initialized)
	
	if level_data.is_initialized:
		_assign_ids(level_data)
		_regenerate_assets(level_data)
	else:
		_assign_ids(level_data)
		_assign_root_ids_to_ships()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit_ship"):
		serialize_level()
		
		
		var parent_level_data: LevelData = LevelLoader.load_level(parent_id)
		LevelLoader.set_level_as_current(parent_level_data.level_id)
		var parent_level_packed_scene = PrefabLoader.load_level(parent_level_data)
		get_tree().change_scene_to_packed(parent_level_packed_scene)

	
	
func serialize_level() -> void:
	var level_data: LevelData = _generate_level_data()
	LevelLoader.save_level(level_data)
	
	
func _assign_ids(level_data: LevelData) -> void:
	level_id = level_data.level_id
	parent_id = level_data.parent_id
	ship_type = level_data.ship_type

func _generate_level_data() -> LevelData:
	var level_data: LevelData = LevelData.new()
	
	level_data.level_id = level_id
	level_data.parent_id = parent_id
	
	level_data.player_position = _get_player().position
	var ships: Array[ShipData] = []
	
	for ship in super._get_ships():
		if not ship is BottledShip: continue
		
		ships.append(ship.generate_ship_data())	
	
	level_data.ships = ships
	
	level_data.is_initialized = true
	level_data.ship_type = ship_type
	
	return level_data
	
