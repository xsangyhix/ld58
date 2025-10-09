extends State
class_name StateShipBreak


@export var bottled_ship_controller: BottledShip


func enter(_fsm_context: FsmContext) -> void:
	bottled_ship_controller._play_break()
	bottled_ship_controller.ship_ui_controller.set_ship_label_visibility(false)
	
	trigger_remove_after_delay(10)

func trigger_remove_after_delay(delay: float) -> void:
	await get_tree().create_timer(delay).timeout
	bottled_ship_controller.get_parent().remove_child(bottled_ship_controller)
	bottled_ship_controller.queue_free()
