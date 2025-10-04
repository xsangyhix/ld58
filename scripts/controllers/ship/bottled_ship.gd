extends Node2D

var ship_area_2d: Area2D
var ship_ui_controller: ShipUiController
var ship_state_machine: StateMachine


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
	
	ship_state_machine.request_state("StateShipActive")


func _process(_delta: float) -> void:

	_process_ship_visibility()
	
#	if fsm_context["load_ship"]:
#		_load_next_ship()
		
		
func _load_next_ship() -> void:
	var ship_packed_scene = PrefabLoader.load_ship_01()
	get_tree().change_scene_to_packed(ship_packed_scene)

func _process_ship_visibility() -> void:
	var fsm_context_memory = ship_state_machine.fsm_context.context_memory
	
	if not fsm_context_memory.has("is_ship_enter_label_visible"): return
	
	var target_visibility = fsm_context_memory["is_ship_enter_label_visible"]
	if ship_ui_controller.is_ship_etner_label_visible() != target_visibility:
		ship_ui_controller.set_ship_enter_label_visibility(target_visibility)
	