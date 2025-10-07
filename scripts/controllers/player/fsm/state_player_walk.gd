extends State
class_name StatePlayerWalk


@export var player_animated_sprite: AnimatedSprite2D
@export var player_controller: PlayerController
@export var _fsm: StateMachine


func enter(_fsm_context: FsmContext) -> void:
	player_animated_sprite.set_animation("walk")
	
func update(_delta: float, _fsm_context: FsmContext) -> void:
	var player_velocity: Vector2 = player_controller.velocity
	
	if player_velocity.length() < 1:
		_fsm.request_state("StatePlayerIdle")
		return
		
	if player_controller.is_on_floor():
		return	
	
	if player_velocity.y < 0:
		_fsm.request_state("StatePlayerJump")
		return
		
	if player_velocity.y > 0:
		_fsm.request_state("StatePlayerFall")
		return
				
	
		
