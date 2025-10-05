class_name LevelLoader


static func save_level(level_data: LevelData) -> void:
	var file_path: String = _generate_level_path(level_data.level_id)
	_save(file_path, level_data)
	
static func save_current_level(level_data: LevelData) -> void:
	var file_path: String = _generate_level_path("current")
	_save(file_path, level_data)
	

static func load_level(level_id: String) -> LevelData:
	var file_path: String = _generate_level_path(level_id)
	return _load(file_path)
	
static func load_current_level() -> LevelData:
	var file_path: String = _generate_level_path("current")
	return _load(file_path)
	
	
static func set_level_as_current(level_id: String) -> void:
	var level_data: LevelData = load_level(level_id)
	save_current_level(level_data)
	
	
static func _load(file_path: String) -> LevelData:
	return ResourceLoader.load(file_path)


static func _save(file_path: String, level_data: LevelData) -> void:
	ResourceSaver.save(level_data, file_path)
	
	
static func _generate_level_path(level_id: String) -> String:
	var save_dir_path: String = _generate_save_directory_path()
	return "{save_dir_path}/level_{level_id}.tres".format({"save_dir_path": save_dir_path, "level_id": level_id})


static func _generate_player_path() -> String:
	return "{save_dir}/player.tres".format({"save_dir": _generate_save_directory_path()})

	
static func load_player() -> PlayerData:
	return ResourceLoader.load(_generate_player_path())
	
	
static func save_player(player_data: PlayerData) -> void:
	ResourceSaver.save(player_data, _generate_player_path())
	

static func _generate_save_directory_path() -> String:
	return "res://save/"


static func does_level_exist(level_id: String) -> bool:
	var file_path: String = _generate_level_path(level_id)
	return ResourceLoader.exists(file_path)


static func does_player_exist() -> bool:
	return ResourceLoader.exists(_generate_player_path())

static func remove_saved_files() -> void:
	var save_directory: DirAccess = DirAccess.open(_generate_save_directory_path())
	var save_files: PackedStringArray = save_directory.get_files()
	
	for file_path in save_files:
		save_directory.remove(file_path)
