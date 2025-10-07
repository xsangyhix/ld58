extends Node2D
class_name GhostController


@export var area_2d: Area2D

@export var damage: int = 1
@export var idle_speed: float = 10
@export var aggro_speed: float = 20

var _target_movement: Vector2



func _ready() -> void:
	area_2d.body_entered.connect(_on_body_enter)


func _on_body_enter(body: Node2D) -> void:
	if body.is_in_group("player"):
		var player_body: PlayerController = body
		player_body.deal_damage(damage)
