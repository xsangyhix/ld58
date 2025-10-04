extends Node2D
class_name BottledShip


@export var ship_type: String

var ship_area_2d: Area2D
var ship_ui_controller: ShipUiController
var ship_state_machine: StateMachine
var ship_id: String = UUID.v4()
var parent_id: String


func _ready() -> void:
	ship_state_machine = find_child("StateMachine")

	ship_area_2d = find_child("Area2D")
	ship_area_2d.connect("body_entered", on_player_enter)
	ship_area_2d.connect("body_exited", on_player_exit)
	
	ship_ui_controller = find_child("ShipUIController")
	
func on_player_enter(player_node: Node2D) -> void:
	if not player_node.is_in_group("player"):
		return
	
	ship_state_machine.request_state("StateShipActive")


func on_player_exit(player_node: Node2D) -> void:
	if not player_node.is_in_group("player"):
		return
	
	ship_state_machine.request_state("StateShipPassive")


func _process(_delta: float) -> void:

	_process_ship_visibility()
	
	if ship_state_machine.fsm_context.get_value_bool("load_ship", false):
		_load_next_ship()
		
		
func _load_next_ship() -> void:
	var does_save_exist = LevelLoader.does_level_exist(ship_id)
	print(does_save_exist)
	
	if does_save_exist:
		LevelLoader.set_level_as_current(ship_id)
	else:
		var new_level_data: LevelData = generate_level_data()
		LevelLoader.save_current_level(new_level_data)
		LevelLoader.save_level(new_level_data)
	
	var scene_root: LevelController = get_tree().current_scene
	if scene_root is LevelController:
		scene_root.serialize_level()
	
	var ship_packed_scene = PrefabLoader.load_level(LevelLoader.load_current_level())
	get_tree().change_scene_to_packed(ship_packed_scene)


func _process_ship_visibility() -> void:
	var fsm_context_memory = ship_state_machine.fsm_context.context_memory
	
	if not fsm_context_memory.has("is_ship_enter_label_visible"): return
	
	var target_visibility = fsm_context_memory["is_ship_enter_label_visible"]
	if ship_ui_controller.is_ship_etner_label_visible() != target_visibility:
		ship_ui_controller.set_ship_enter_label_visibility(target_visibility)
	
func generate_ship_data() -> ShipData:
	var ship_data: ShipData = ShipData.new()
	
	ship_data.ship_position = position
	ship_data.ship_id = ship_id
	ship_data.ship_type = ship_type
	
	return ship_data
	
func generate_level_data() -> LevelData:
	var level_data: LevelData = LevelData.new()
	level_data.is_initialized = false
	level_data.level_id = ship_id
	level_data.parent_id = parent_id
	level_data.ship_type = ship_type
	
	return level_data
