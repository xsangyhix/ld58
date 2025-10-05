extends CharacterBody2D
class_name PlayerController

@export var speed: float = 300.0
@export var jump_velocity: float = -400.0
@export var _ui_controller: PlayerUiController
@export var _player_sprite: Sprite2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var moving_right: bool = true
var _audio_hub: AudioHub

var _collected_ships: Array[ShipData] = []


func _ready() -> void:
	_audio_hub = get_node("/root/MainAudioHub")
	deserialize_player()

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
		_player_sprite.set_flip_h(true)
		
	if (not moving_right) and input_direction > 0:
		moving_right = true
		_player_sprite.set_flip_h(false)


func deserialize_player() -> void:
	if not LevelLoader.does_player_exist():
		return

	var player_data: PlayerData = LevelLoader.load_player()
	
	_ui_controller.set_player_hp(player_data.player_hp)
	_collected_ships = player_data.collected_ships
	_ui_controller.set_ship_count(_collected_ships.size())

func serialize_player() -> void:
	var player_data: PlayerData = PlayerData.new()
	
	player_data.player_hp = _ui_controller.get_player_hp()
	player_data.collected_ships = _collected_ships
	
	LevelLoader.save_player(player_data)


func collect_ship(ship_data: ShipData) -> void:
	_collected_ships.append(ship_data)
	_ui_controller.add_ship()
	_audio_hub.play_collect_bottle()


func deal_damage(damage_points: int) -> void:
	_ui_controller.remove_player_hp(damage_points)
