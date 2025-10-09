extends CharacterBody2D
class_name PlayerController

@export var speed: float = 300.0
@export var jump_velocity: float = -400.0
@export var acceleration: float = 100
@export var deceleration: float = 200
@export var floor_drag: float = 500
@export var coyote_time: float = 0.5


@export var _player_sprite: AnimatedSprite2D
@export var _is_title_screen: bool = false


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var moving_right: bool = true
var _time_airborne: float
var _used_double_jump: bool = false
var _was_on_floor: bool = true


var _collected_ships: Array[ShipData] = []
var times_entered_root: int = 0


func _ready() -> void:
	deserialize_player()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		_time_airborne += delta
	else:
		_time_airborne = 0
		_used_double_jump = false
	
	if _is_title_screen: return
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and _can_jump():
		velocity.y = jump_velocity
		MainAudioHub.play_jump()
		_time_airborne += coyote_time
	elif Input.is_action_just_pressed("jump") and _can_double_jump():
		velocity.y = jump_velocity
		MainAudioHub.play_jump()
		_used_double_jump = true
		
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		velocity.x = move_toward(velocity.x, speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, floor_drag * delta)

	move_and_slide()
	
	if not _was_on_floor and is_on_floor():
		MainAudioHub.play_land()
	
	_was_on_floor = is_on_floor()


func _process(_delta: float) -> void:
	if _is_title_screen:
		velocity = Vector2.ZERO
		return
	
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
	
	RootUi.player_ui_controller.set_player_hp(player_data.player_hp)
	_collected_ships = player_data.collected_ships
	RootUi.player_ui_controller.set_ship_count(_collected_ships.size())
	times_entered_root = player_data.times_entered_root

func serialize_player() -> void:
	var player_data: PlayerData = PlayerData.new()
	
	player_data.player_hp = RootUi.player_ui_controller.get_player_hp()
	player_data.collected_ships = _collected_ships
	player_data.times_entered_root = times_entered_root
	
	LevelLoader.save_player(player_data)


func collect_ship(ship_data: ShipData) -> void:
	_collected_ships.append(ship_data)
	RootUi.player_ui_controller.add_ship()
	MainAudioHub.play_collect_bottle()


func deal_damage(damage_points: int) -> void:
	RootUi.player_ui_controller.remove_player_hp(damage_points)


func _can_jump() -> bool:
	return is_on_floor() or _time_airborne < coyote_time
	
func _can_double_jump() -> bool:
	return not _used_double_jump
