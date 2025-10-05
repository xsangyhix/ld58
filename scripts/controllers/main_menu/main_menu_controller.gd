extends Node2D
class_name MainMenuController


@export var menu_ui_controller: MenuUiController

func _ready() -> void:
	menu_ui_controller.start_game_button.pressed.connect(start_new_game)
	menu_ui_controller.continue_game_button.pressed.connect(resume_game)
	


func start_new_game() -> void:
	LevelLoader.remove_saved_files()
	_load_root_scene()
	
	
func resume_game() -> void:
	_load_current_scene()
	
func _generate_root_level_data() -> LevelData:
	var level_data = LevelData.new()
	level_data.level_id = "root"
	level_data.is_root = true
	
	return level_data
	
func _load_root_scene() -> void:
	var root_scene: Resource = PrefabLoader.load_level(_generate_root_level_data())
	get_tree().change_scene_to_packed(root_scene)


func _load_current_scene() -> void:
	var current_level_data = LevelLoader.load_current_level()
	var current_scene: Resource = PrefabLoader.load_level(current_level_data)
	get_tree().change_scene_to_packed(current_scene)
