extends CharacterBody2D
class_name PlayerController

@export var speed: float = 300.0
@export var jump_velocity: float = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var moving_right: bool = true
var player_sprite: Sprite2D


func _ready() -> void:
	player_sprite = find_child("PlayerSprite")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func _process(_delta: float) -> void:
	var input_direction: float = Input.get_axis("ui_left", "ui_right")
	
	if moving_right and input_direction < 0:
		moving_right = false
		player_sprite.set_flip_h(true)
		
	if (not moving_right) and input_direction > 0:
		moving_right = true
		player_sprite.set_flip_h(false)
