extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -250.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var flashlight: Light2D = $Flashlight

# Position of flashlight relative to player hand when facing right
var flashlight_hand_pos := Vector2(0, 0)  # adjust to match hand

func flip_flashlight(facing_right: bool) -> void:
	if facing_right:
		flashlight.scale.x = 0.654   # original scale.x
		flashlight.position = flashlight_hand_pos
	else:
		flashlight.scale.x = -0.654 # mirror scale.x
		# Mirror X for left-facing direction
		flashlight.position = Vector2(-flashlight_hand_pos.x, flashlight_hand_pos.y)
	if facing_right:
		flashlight.position = Vector2(0, 0)  # hand location
	else:
			flashlight.position = Vector2(-50, -2)
			
		
	

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal input (-1, 0, 1)
	var direction := Input.get_axis("move_left", "move_right")

	# Flip sprite and flashlight
	if direction > 0:
		animated_sprite.flip_h = false
		flip_flashlight(true)
	elif direction < 0:
		animated_sprite.flip_h = true
		flip_flashlight(false)

	# Horizontal movement
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	# Move character
	move_and_slide()