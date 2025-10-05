class_name PrefabLoader


static func load_ship_01() -> Resource:
	return load("res://scenes/levels/ship_01.tscn")

static func load_ship_02() -> Resource:
	return load("res://scenes/levels/ship_02.tscn")
	
static func load_bottled_ship(ship_type: String) -> Resource:
	if ship_type == "default":
		return load("res://scenes/objects/bottled_ship.tscn")
	
	else:
		return load("res://scenes/objects/bottled_ship.tscn")

static func load_level(level_data: LevelData) -> Resource:
	if level_data.is_root:
		return load("res://scenes/root_scene.tscn")
		
	if level_data.ship_type == "ship_01":
		return load_ship_01()
		
	if level_data.ship_type == "ship_02":
		return load_ship_02()
		
	else:
		return load_ship_01()
