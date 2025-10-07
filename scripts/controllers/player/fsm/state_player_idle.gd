extends State
class_name StatePlayerIdle


@export var player_animated_sprite: AnimatedSprite2D
@export var player_controller: PlayerController
@export var _fsm: StateMachine

func enter(_fsm_context: FsmContext) -> void:
	player_animated_sprite.set_animation("idle")
	
func update(_delta: float, _fsm_context: FsmContext) -> void:
	var player_velocity: Vector2 = player_controller.velocity
	
	if not player_controller.is_on_floor() and player_velocity.y < 0:
		_fsm.request_state("StatePlayerJump")
		return
		
	if not player_controller.is_on_floor() and player_velocity.y > 0:
		_fsm.request_state("StatePlayerFall")
		return
	
	if player_velocity.length() > 1:
		_fsm.request_state("StatePlayerWalk")
		return