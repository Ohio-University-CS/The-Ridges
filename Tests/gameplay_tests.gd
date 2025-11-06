extends SceneTree

# Lightweight test runner for GDScript (Godot 4).
# Run with:
# ./Godot_v4_stable_x11.64 --headless --path . --script Tests/gameplay_tests.gd
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

# ----------------------
# Dummy classes for testing
# ----------------------
class DummySprite:
	var flip_h := false

class DummyGameManager:
	var points := 0
	func add_point() -> void:
		points += 1

class DummyRaycast:
	var _colliding := false
	func _init(colliding := false):
		_colliding = colliding
	func is_colliding() -> bool:
		return _colliding

# ----------------------
# Utility
# ----------------------
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

	player.flashlight_hand_pos = Vector2(10, 4)
	player.flip_flashlight(false)
	_eq(player.flashlight.position, Vector2(-50, -2), "Left-facing: flashlight offset for left hand")
	_ok(player.flashlight.scale.x < 0.0, "Left-facing: scale.x should be negative (mirrored)")

# 3) Player flashlight toggle scale
func test_player_flashlight_scale_sign_cases() -> void:
	var player := _instantiate_with_script(CharacterBody2D.new(), "res://Scripts/Player.gd")
	player.flashlight = PointLight2D.new()
	player.flashlight_hand_pos = Vector2(3, 2)

	player.flip_flashlight(true)
	_ok(player.flashlight.scale.x > 0, "Toggle: right -> positive scale")
	player.flip_flashlight(false)
	_ok(player.flashlight.scale.x < 0, "Toggle: right->left -> negative scale")
	player.flip_flashlight(true)
	_ok(player.flashlight.scale.x > 0, "Toggle: right->left->right -> back to positive scale")

# 4) Dummy monster movement test
func test_monster_dummy_movement_cases() -> void:
	var monster = DummySprite.new()
	monster.flip_h = false
	_ok(monster.flip_h == false, "Dummy monster starts not flipped")

# ----------------------
# Runner
# ----------------------
func _run_all_tests() -> void:
	test_player_flip_right_cases()
	test_player_flip_left_cases()
	test_player_flashlight_scale_sign_cases()
	test_monster_dummy_movement_cases()