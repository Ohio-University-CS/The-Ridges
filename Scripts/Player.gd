extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -250.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var flashlight: Light2D = $Flashlight

# Position of flashlight relative to player hand when facing right
var flashlight_hand_pos := Vector2(0, 0)

# Flashlight state
var flashlight_enabled: bool = true

func flip_flashlight(facing_right: bool) -> void:
	if facing_right:
		flashlight.scale.x = 0.654
		flashlight.position = flashlight_hand_pos
	else:
		flashlight.scale.x = -0.654
		flashlight.position = Vector2(-flashlight_hand_pos.x, flashlight_hand_pos.y)
	if facing_right:
		flashlight.position = Vector2(0, 0)
	else:
		flashlight.position = Vector2(-50, -2)

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal input
	var direction := Input.get_axis("move_left", "move_right")

	# Flip sprite and flashlight
	if direction > 0:
		animated_sprite.flip_h = false
		if flashlight_enabled:
			flip_flashlight(true)
	elif direction < 0:
		animated_sprite.flip_h = true
		if flashlight_enabled:
			flip_flashlight(false)

	
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("run")

	# Flashlight toggle (press F)
	if Input.is_action_just_pressed("flashlight_toggle"):
		flashlight_enabled = not flashlight_enabled
		flashlight.visible = flashlight_enabled

	
	_update_monsters_light_exposure()

	# Move character
	move_and_slide()

func _ready():
	if not is_in_group("player"):
		add_to_group("player")

# Monster (Rufus) light detection

func _update_monsters_light_exposure() -> void:
	if not flashlight_enabled:
		for m in get_tree().get_nodes_in_group("monsters"):
			if is_instance_valid(m) and m.has_method("set_afraid_of_light"):
				m.set_afraid_of_light(false)
		return

	var light_pos: Vector2 = flashlight.global_position
	var cone_dir: Vector2 = Vector2.RIGHT if not animated_sprite.flip_h else Vector2.LEFT
	var half_angle_rad: float = deg_to_rad(40)
	var flashlight_range: float = 300.0

	for monster in get_tree().get_nodes_in_group("monsters"):
		if not is_instance_valid(monster):
			continue

		var to_mon: Vector2 = monster.global_position - light_pos
		var dist: float = to_mon.length()
		if dist > flashlight_range:
			if monster.has_method("set_afraid_of_light"):
				monster.set_afraid_of_light(false)
			continue

		var to_mon_dir: Vector2 = to_mon.normalized()
		var angle_to_mon: float = cone_dir.angle_to(to_mon_dir)
		if abs(angle_to_mon) > half_angle_rad:
			if monster.has_method("set_afraid_of_light"):
				monster.set_afraid_of_light(false)
			continue

		if monster.has_method("set_afraid_of_light"):
			monster.set_afraid_of_light(true)