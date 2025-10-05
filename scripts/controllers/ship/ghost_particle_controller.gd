extends GPUParticles2D
class_name GhostParticleController

@export var ship_root: BottledShip

var _breaking: bool = false


func _process(_delta: float) -> void:
	
	if not _breaking and ship_root._get_fsm_context_bool("break"):
		_breaking = true
		_trigger_release_ghosts()
		
		
func _trigger_release_ghosts() -> void:
	lifetime = 10
	amount = 10
	one_shot = true
	explosiveness = 1
