extends CanvasLayer
class_name RootUiController


@export var player_ui_controller: PlayerUiController
@export var dialogue_ui_controller: DialogueUiController
@export var menu_ui_controller: MenuUiController


func _ready() -> void:
	GameEventBus.scene_started.connect(_update_scene_ui)
	
	
func _update_scene_ui(scene_type: GameEnums.scene_type) -> void:
	match scene_type:
		GameEnums.scene_type.MAIN_MENU:
			player_ui_controller.visible = false
			dialogue_ui_controller.visible = true
			menu_ui_controller.visible = true
		GameEnums.scene_type.ROOT_SHIP_SCENE:
			player_ui_controller.visible = true
			dialogue_ui_controller.visible = true
			menu_ui_controller.visible = false
		GameEnums.scene_type.SHIP_SCENE:
			player_ui_controller.visible = true
			dialogue_ui_controller.visible = true
			menu_ui_controller.visible = false
