extends Node2D
class_name LevelExitController


@export var ship_level_controller: ShipLevelController
@export var portal_are2d: Area2D
@export var player_respawn_point: Node2D


func _ready() -> void:
	if not is_instance_valid(ship_level_controller):
		var level_root: Node = get_tree().current_scene
		if level_root is ShipLevelController:
			ship_level_controller = level_root

	portal_are2d.body_entered.connect(_on_body_enter)


func _on_body_enter(body: Node2D) -> void:
	if body.is_in_group("player"):
		exit_to_parent.call_deferred(body)


func exit_to_parent(player_body: PlayerController) -> void:
	RootUi.dialogue_ui_controller.clear_dialogue()
	player_body.visible = false
	player_body.position = player_respawn_point.position
	
	ship_level_controller.exit_to_parent()
