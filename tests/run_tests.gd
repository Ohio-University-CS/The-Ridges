extends SceneTree

# Lightweight test runner for GDScript. Run with:
# godot --headless --path . --script tests/run_tests.gd
# Exits with non-zero code if any test fails.

var failures := 0
var total_asserts := 0

func _initialize() -> void:
	print("Running GDScript unit tests...\n")
	_run_all_tests()
	if failures == 0:
		print("\nAll tests passed (" + str(total_asserts) + " checks). ✅")
		quit(0)
	else:
		print("\nTests failed: " + str(failures) + " checks failed out of " + str(total_asserts) + ". ❌")
		quit(1)

# ----------------------
# Assertion helpers
# ----------------------
func _ok(cond: bool, msg: String) -> void:
	total_asserts += 1
	if not cond:
		failures += 1
		push_error("ASSERT FAILED: %s" % msg)

func _eq(a, b, msg: String = "") -> void:
	_ok(a == b, msg + " | expected=%s actual=%s" % [str(b), str(a)])

func _near(a: float, b: float, eps: float, msg: String = "") -> void:
	_ok(abs(a - b) <= eps, msg + " | expected≈%s actual=%s" % [str(b), str(a)])

# Small stubs to isolate logic
class DummyRaycast:
	var _colliding := false
	func _init(colliding := false):
		_colliding = colliding
	func is_colliding() -> bool:
		return _colliding

class DummySprite:
	var flip_h := false

class DummyGameManager:
	var points := 0
	func add_point() -> void:
		points += 1

# Utility to instantiate a Node with a script attached
func _instantiate_with_script(base: Object, script_path: String) -> Object:
	var script := load(script_path)
	var node := base
	node.set_script(script)
	return node

# ----------------------
# Tests (10 functions; each has 3+ cases)
# ----------------------
# 1) Player.flip_flashlight(): facing right cases
func test_player_flip_right_cases() -> void:
	var player := _instantiate_with_script(CharacterBody2D.new(), "res://Scripts/Player.gd")
	var light := PointLight2D.new()
	player.flashlight = light

	# Case 1: Normal hand pos -> position should be (0,0) by script override, scale.x positive
	player.flashlight_hand_pos = Vector2(12, 3)
	player.flip_flashlight(true)
	_eq(player.flashlight.position, Vector2(0, 0), "Right-facing: flashlight anchored to hand override")
	_ok(player.flashlight.scale.x > 0.0, "Right-facing: scale.x should be positive")

	# Case 2: Edge: hand pos at origin
	player.flashlight_hand_pos = Vector2(0, 0)
	player.flip_flashlight(true)
	_eq(player.flashlight.position, Vector2(0, 0), "Right-facing (origin hand): position still (0,0)")
	_ok(player.flashlight.scale.x > 0.0, "Right-facing (origin hand): scale.x positive")

	# Case 3: Edge: negative hand coordinates
	player.flashlight_hand_pos = Vector2(-20, -5)
	player.flip_flashlight(true)
	_eq(player.flashlight.position, Vector2(0, 0), "Right-facing (negative hand): position still forced to (0,0)")
	_ok(player.flashlight.scale.x > 0.0, "Right-facing (negative hand): scale.x positive")

# 2) Player.flip_flashlight(): facing left cases
func test_player_flip_left_cases() -> void:
	var player := _instantiate_with_script(CharacterBody2D.new(), "res://Scripts/Player.gd")
	var light := PointLight2D.new()
	player.flashlight = light

	# Case 1: Normal -> position forced to (-50,-2), scale.x negative
	player.flashlight_hand_pos = Vector2(10, 4)
	player.flip_flashlight(false)
	_eq(player.flashlight.position, Vector2(-50, -2), "Left-facing: flashlight offset for left hand")
	_ok(player.flashlight.scale.x < 0.0, "Left-facing: scale.x should be negative (mirrored)")

	# Case 2: Edge: origin hand position
	player.flashlight_hand_pos = Vector2(0, 0)
	player.flip_flashlight(false)
	_eq(player.flashlight.position, Vector2(-50, -2), "Left-facing (origin hand): same offset applied")
	_ok(player.flashlight.scale.x < 0.0, "Left-facing (origin hand): negative scale.x")

	# Case 3: Edge: large hand position
	player.flashlight_hand_pos = Vector2(1000, 1000)
	player.flip_flashlight(false)
	_eq(player.flashlight.position, Vector2(-50, -2), "Left-facing (large hand): still clamped to offset")
	_ok(player.flashlight.scale.x < 0.0, "Left-facing (large hand): negative scale.x")

# 3) Player flashlight toggling maintains correct scale sign
func test_player_flashlight_scale_sign_cases() -> void:
	var player := _instantiate_with_script(CharacterBody2D.new(), "res://Scripts/Player.gd")
	player.flashlight = PointLight2D.new()
	player.flashlight_hand_pos = Vector2(3, 2)

	# Case 1: Start right
	player.flip_flashlight(true)
	_ok(player.flashlight.scale.x > 0, "Toggle: right -> positive scale")
	# Case 2: Then left
	player.flip_flashlight(false)
	_ok(player.flashlight.scale.x < 0, "Toggle: right->left -> negative scale")
	# Case 3: Then right again
	player.flip_flashlight(true)
	_ok(player.flashlight.scale.x > 0, "Toggle: right->left->right -> back to positive scale")

# 4) Monster._process: movement and flips
func test_monster_process_movement_cases() -> void:
	var monster = _instantiate_with_script(Node2D.new(), "res://Scripts/monster.gd") as Node2D
	monster.animated_sprite = DummySprite.new()
	monster.raycast_right = DummyRaycast.new(false)
	monster.raycast_left = DummyRaycast.new(false)

	# Case 1: No collision, direction=1, delta=1.0 -> moves right by SPEED
	monster.direction = 1
	var start_x: float = monster.position.x
	monster._process(1.0)
	_near(monster.position.x - start_x, 20.0, 0.001, "Monster moves right by SPEED when free")
	_ok(monster.animated_sprite.flip_h == false, "No flip when moving right by default")

	# Case 2: Right ray colliding -> flips to left (direction=-1) and sprite.flip_h true
	monster.position.x = 0
	monster.raycast_right = DummyRaycast.new(true)
	monster.raycast_left = DummyRaycast.new(false)
	monster._process(0.5)
	_ok(monster.direction == -1, "Collision on right -> move left")
	_ok(monster.animated_sprite.flip_h == true, "Sprite flipped horizontally when turning left")

	# Case 3: Left ray colliding -> flips to right and sprite.flip_h false
	monster.raycast_right = DummyRaycast.new(false)
	monster.raycast_left = DummyRaycast.new(true)
	monster._process(0.25)
	_ok(monster.direction == 1, "Collision on left -> move right")
	_ok(monster.animated_sprite.flip_h == false, "Sprite unflipped when turning right")

# 5) Monster._process: boundary and edge conditions
func test_monster_process_boundary_cases() -> void:
	var monster = _instantiate_with_script(Node2D.new(), "res://Scripts/monster.gd") as Node2D
	monster.animated_sprite = DummySprite.new()

	# Case 1: Both rays colliding -> left then right, ending right
	monster.raycast_right = DummyRaycast.new(true)
	monster.raycast_left = DummyRaycast.new(true)
	monster.direction = -1
	monster._process(0.1)
	_ok(monster.direction == 1, "Both collisions -> final direction right due to last check")

	# Case 2: Zero delta -> no movement
	var x0: float = monster.position.x
	monster._process(0.0)
	_eq(monster.position.x, x0, "Zero delta -> no positional change")

	# Case 3: Negative starting x -> still moves correctly
	monster.position.x = -100
	monster.raycast_right = DummyRaycast.new(false)
	monster.raycast_left = DummyRaycast.new(false)
	monster.direction = 1
	monster._process(0.5)
	_ok(monster.position.x > -100, "Negative origin still allows movement")

# 6) Coin._on_body_entered: scoring and freeing
func test_coin_on_body_entered_cases() -> void:
	var coin := _instantiate_with_script(Area2D.new(), "res://Scripts/coin.gd")
	var gm := DummyGameManager.new()
	coin.game_manager = gm

	# Case 1: Single pickup increments score
	coin._on_body_entered(Node2D.new())
	_eq(gm.points, 1, "Coin pickup increments score by 1")
	_ok(coin.is_queued_for_deletion(), "Coin queued for deletion after pickup")

	# Case 2: Multiple coins -> create another coin and pickup again
	var coin2 := _instantiate_with_script(Area2D.new(), "res://Scripts/coin.gd")
	coin2.game_manager = gm
	coin2._on_body_entered(Node2D.new())
	_eq(gm.points, 2, "Second coin increments score again")
	_ok(coin2.is_queued_for_deletion(), "Second coin queued for deletion")

	# Case 3: Edge: Different body types (still Node2D)
	var coin3 := _instantiate_with_script(Area2D.new(), "res://Scripts/coin.gd")
	coin3.game_manager = gm
	var custom_body := Node2D.new()
	coin3._on_body_entered(custom_body)
	_eq(gm.points, 3, "Any Node2D body triggers pickup")

# 7) Killzone._on_body_entered: time scale, timer, and collision removal
func test_killzone_body_entered_cases() -> void:
	var kz := _instantiate_with_script(Area2D.new(), "res://Scripts/killzone.gd")
	var t := Timer.new()
	t.name = "Timer"  # ensure the onready $Timer path resolves
	kz.add_child(t)
	# Add to the active SceneTree so Timer.start() works and get_tree() is valid
	get_root().add_child(kz)
	await process_frame

	var body := Node2D.new()
	var collider := CollisionShape2D.new()
	collider.name = "CollisionShape2D"
	body.add_child(collider)

	# Case 1: Enter -> time scale reduced
	Engine.time_scale = 1.0
	kz._on_body_entered(body)
	_near(Engine.time_scale, 0.5, 0.0001, "Killzone halves time scale on death")

	# Case 2: Collider queued for deletion
	_ok(collider.is_queued_for_deletion(), "Body collider queued for deletion on death")

	# Case 3: Timer started (time_left > 0 shortly after start)
	_ok(kz.timer.is_stopped() == false, "Timer started after death")

# 8) Killzone._on_timer_timeout: time scale restore
func test_killzone_timeout_cases() -> void:
	var kz := _instantiate_with_script(Area2D.new(), "res://Scripts/killzone.gd")
	# Ensure node is inside the SceneTree to make get_tree() non-null
	get_root().add_child(kz)
	await process_frame
	# Provide a dummy current_scene so reload_current_scene() doesn't error
	current_scene = Node2D.new()
	# Case 1: From slow motion back to normal
	Engine.time_scale = 0.25
	kz._on_timer_timeout()
	_near(Engine.time_scale, 1.0, 0.0001, "Timeout restores normal time scale")

	# Case 2: Idempotency when already 1.0
	Engine.time_scale = 1.0
	kz._on_timer_timeout()
	_near(Engine.time_scale, 1.0, 0.0001, "Timeout keeps time scale at 1.0 if already normal")

	# Case 3: Call multiple times
	kz._on_timer_timeout()
	_near(Engine.time_scale, 1.0, 0.0001, "Multiple timeouts remain safe")

# 9) Player constants and basic expectations
func test_player_constants_cases() -> void:
	var player := _instantiate_with_script(CharacterBody2D.new(), "res://Scripts/Player.gd")
	# Set required deps to avoid nulls later
	player.flashlight = PointLight2D.new()

	# Case 1: SPEED positive
	_ok(player.SPEED > 0, "Player SPEED should be positive")
	# Case 2: JUMP_VELOCITY negative (upwards)
	_ok(player.JUMP_VELOCITY < 0, "Player JUMP_VELOCITY should be negative (upward impulse)")
	# Case 3: Flashlight exists and is Light2D
	_ok(player.flashlight is Light2D, "Player.flashlight is a Light2D")

# 10) Monster defaults and flip behavior sequence
func test_monster_defaults_and_flip_sequence_cases() -> void:
	var monster = _instantiate_with_script(Node2D.new(), "res://Scripts/monster.gd") as Node2D
	monster.animated_sprite = DummySprite.new()

	# Case 1: Default direction is 1 (right)
	_ok(monster.direction == 1, "Monster default direction is right (1)")

	# Case 2: Sequence: collide right then move -> direction becomes -1
	monster.raycast_right = DummyRaycast.new(true)
	monster.raycast_left = DummyRaycast.new(false)
	monster._process(0.1)
	_ok(monster.direction == -1, "After right collision, direction is -1")

	# Case 3: Then collide left -> direction becomes 1
	monster.raycast_right = DummyRaycast.new(false)
	monster.raycast_left = DummyRaycast.new(true)
	monster._process(0.1)
	_ok(monster.direction == 1, "After left collision, direction is 1")

# ----------------------
# Runner
# ----------------------
func _run_all_tests() -> void:
	# IMPORTANT: keep calls ordered for deterministic output
	test_player_flip_right_cases()
	test_player_flip_left_cases()
	test_player_flashlight_scale_sign_cases()
	test_monster_process_movement_cases()
	test_monster_process_boundary_cases()
	test_coin_on_body_entered_cases()
	test_killzone_body_entered_cases()
	test_killzone_timeout_cases()
	test_player_constants_cases()
	test_monster_defaults_and_flip_sequence_cases()
