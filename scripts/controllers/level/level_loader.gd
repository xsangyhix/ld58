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
	return "res://save/level_%s.tres" % [level_id]


static func does_level_exist(level_id: String) -> bool:
	var file_path: String = _generate_level_path(level_id)
	print(file_path)
	return ResourceLoader.exists(file_path)
