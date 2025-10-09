extends LevelController
class_name RootLevelController



func _ready() -> void:
	GameEventBus.scene_started.emit(GameEnums.scene_type.ROOT_SHIP_SCENE)
	if LevelLoader.does_level_exist("root"):
		var root_level_data: LevelData = LevelLoader.load_level("root")
		_regenerate_assets(root_level_data)
	
	_assign_root_ids_to_ships()
	
	serialize_level()
	LevelLoader.set_level_as_current("root")
	
	var player: PlayerController = _get_player()
	player.times_entered_root += 1
	GameEventBus.player_entered_root.emit(player)

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
		if ship.is_marked_to_destroy(): continue
		
		ships_data.append(ship.generate_ship_data())
		
	level_data.ships = ships_data
	
	LevelLoader.save_level(level_data)
