extends LevelController
class_name RootLevelController



func _ready() -> void:		
	var root_level_data: LevelData = LevelLoader.load_level("root")
	
	if LevelLoader.does_level_exist("root"):
		_regenerate_assets(root_level_data)
	
	_assign_root_ids_to_ships()

func get_level_id() -> String:
	return "root"
	

func serialize_level() -> void:
	_get_player().serialize_player()

	var level_data: LevelData = LevelData.new()
	level_data.is_root = true
	level_data.level_id = get_level_id()
	level_data.player_position = _get_player().position
	var ship_objects: Array[BottledShip] =  super._get_ships()
	
	var ships_data: Array[ShipData] = []
	for ship in ship_objects:
		if not ship is BottledShip: continue
		
		ships_data.append(ship.generate_ship_data())
		
	level_data.ships = ships_data
	
	LevelLoader.save_level(level_data)
