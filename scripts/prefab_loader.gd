class_name PrefabLoader


static func load_ship(ship_name: String, ship_tier: String) -> Resource:
	return load("res://scenes/levels/{tier}/{ship_name}.tscn".format({"ship_name": ship_name, "tier": ship_tier}))


static func load_bottled_ship(ship_data: ShipData) -> Resource:
	var ship_tier: String = ship_data.ship_tier
	if ship_tier == "default":
		return load("res://scenes/objects/bottled_ship.tscn")
	elif ship_tier == "T1":
		return load("res://scenes/objects/bottled_ship_T1.tscn")
	elif ship_tier == "T2":
		return load("res://scenes/objects/bottled_ship_T2.tscn")
	elif ship_tier == "T3":
		return load("res://scenes/objects/bottled_ship_T3.tscn")
	else:
		return load("res://scenes/objects/bottled_ship.tscn")


static func load_level(level_data: LevelData) -> Resource:
	if level_data.is_root:
		return load("res://scenes/root_scene.tscn")
	
	return load_ship(level_data.ship_type, level_data.ship_tier)
