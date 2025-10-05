extends Node2D
class_name LevelController


@export var _objects: Node


var level_id: String


func get_level_id() -> String:
	return level_id
	

func serialize_level() -> void:
	pass
	


func _get_player() -> PlayerController:
	var player_nodes := get_tree().get_nodes_in_group("player")
	
	if player_nodes.size() == 0:
		push_error("Player not found! Returning null.")
		return null
	
	if player_nodes.size() > 1:
		push_error("More than one player! Returning first one.")
		
	if not player_nodes[0] is PlayerController:
		push_error("Invalid player node type. Returning null.")
		return null
		
	return player_nodes[0]
	
	
func _get_ships() -> Array[BottledShip]:
	var ship_array: Array[BottledShip] = []
	
	var ship_nodes: Array[Node] = get_tree().get_nodes_in_group("ships")
	for ship_node in ship_nodes:
		if not ship_node is BottledShip: continue
		
		ship_array.append(ship_node)
		
	return ship_array


func _regenerate_assets(level_data: LevelData) -> void:

	if level_data.player_position != null:
		var player: PlayerController = _get_player()
		player.position = level_data.player_position

	for ship in _get_ships():
		if not ship is BottledShip: continue
			
		ship.get_parent().remove_child(ship)
		ship.queue_free()
		
	for ship_data in level_data.ships:
		var packaged_ship_scene: Resource = PrefabLoader.load_bottled_ship(ship_data)
		var bottled_ship: BottledShip = packaged_ship_scene.instantiate()
		_objects.add_child(bottled_ship)
		bottled_ship.position = ship_data.ship_position
		bottled_ship.ship_id = ship_data.ship_id
		bottled_ship.ship_tier = ship_data.ship_tier
		bottled_ship.ship_type = ship_data.ship_type
		
		if ship_data.is_bottle_broken:
			bottled_ship.mark_to_destroy()
	
	_assign_root_ids_to_ships()
	
	level_data.clean_up_broken_ships()
	LevelLoader.save_level(level_data)

func _assign_root_ids_to_ships() -> void:
	for ship in _get_ships():
		if not ship is BottledShip: continue
		
		ship.parent_id = get_level_id()
