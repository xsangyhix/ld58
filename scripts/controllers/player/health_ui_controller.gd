extends Control
class_name HealthUiController


@export var health_bar_background: ColorRect
@export var health_bar: ColorRect


var _hp: int = 100
var _max_hp: int = 100

var background_width: float
var background_height: float


func _ready() -> void:
	background_width = health_bar_background.size.x
	background_height = health_bar_background.size.y


func set_hp(input_hp: int) -> void:
	_hp = clampi(input_hp, 0, _max_hp)
	_update_rect()

func add_hp(hp_change: int) -> void:
	set_hp(_hp + hp_change)
	
	
func set_max_hp() -> void:
	set_hp(_max_hp)

func _update_rect() -> void:
	var target_health_bar_width: float = _get_hp_percentage() * background_width
	var target_health_bar_size: Vector2 = Vector2(target_health_bar_width,background_height)
	
	health_bar.size = target_health_bar_size

func _get_hp_percentage() -> float:
	return clampf(float(_hp)/float(_max_hp), 0, 1)
	
func get_hp() -> int:
	return _hp
	
