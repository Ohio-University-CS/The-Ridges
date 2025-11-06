extends CharacterBody2D

#movement 
@export var speed: float = 40.0
@export var gravity: float = 1200.0

# animation names 
@export var anim_idle_name: String = "Idle"
@export var anim_run_name: String = "run"

#AI
var fleeing: bool = false
var player: Node = null
var roam_target: Vector2 = Vector2.ZERO
var roam_timer: float = 0.0

# roaming parameters
@export var roam_distance: float = 200.0
@export var roam_time_min: float = 1.0
@export var roam_time_max: float = 3.0

# chasing/fleeing parameters
@export var chase_range: float = 250.0


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	if not is_in_group("monsters"):
		add_to_group("monsters")
	
	# Find player in the scene
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

	_set_new_roam_target()

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if velocity.y > 0:
			velocity.y = 0

	var move_dir: Vector2 = Vector2.ZERO

	if fleeing and player:
		move_dir = (global_position - player.global_position).normalized()
	elif player and global_position.distance_to(player.global_position) < chase_range:
		# Chase player
		move_dir = (player.global_position - global_position).normalized()
	else:
		# Roaming
		_roam(delta)
		move_dir = (roam_target - global_position)
		if move_dir.length() > 0:
			move_dir = move_dir.normalized()

	# Set horizontal velocity
	velocity.x = move_dir.x * speed

	# Flip sprite
	if velocity.x != 0:
		animated_sprite.flip_h = velocity.x < 0

	# Handle animations
	if abs(velocity.x) > 1:
		if animated_sprite.sprite_frames.has_animation(anim_run_name):
			animated_sprite.play(anim_run_name)
	else:
		if animated_sprite.sprite_frames.has_animation(anim_idle_name):
			animated_sprite.play(anim_idle_name)

	move_and_slide()  

# Called by player when flashlight is pointing at him
func set_afraid_of_light(is_afraid: bool) -> void:
	fleeing = is_afraid

# roaming 
func _set_new_roam_target() -> void:
	roam_target = global_position + Vector2(randf_range(-roam_distance, roam_distance), 0)
	roam_timer = randf_range(roam_time_min, roam_time_max)

func _roam(delta: float) -> void:
	roam_timer -= delta
	if roam_timer <= 0 or global_position.distance_to(roam_target) < 10:
		_set_new_roam_target()
