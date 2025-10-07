extends State
class_name StatePlayerJump


@export var player_animated_sprite: AnimatedSprite2D
@export var player_controller: PlayerController
@export var _fsm: StateMachine

func enter(_fsm_context: FsmContext) -> void:
	player_animated_sprite.set_animation("jump")
	
	
func update(_delta: float, _fsm_context: FsmContext) -> void:
	if player_controller.is_on_floor():
		_fsm.request_state("StatePlayerIdle")
		return
		
	if player_controller.velocity.y > 0:
		_fsm.request_state("StatePlayerFall")
		return
