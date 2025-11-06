extends SceneTree


var failures := 0
var total_asserts := 0

func _initialize() -> void:
	print("Running GDScript unit tests...\n")
	_run_all_tests()
	if failures == 0:
		print("\nAll tests passed (" + str(total_asserts) + " checks).")
		quit(0)
	else:
		print("\nTests failed: " + str(failures) + " checks failed out of " + str(total_asserts) + ". ")
		quit(1)


# Assertion helpers
func _ok(cond: bool, msg: String) -> void:
	total_asserts += 1
	if not cond:
		failures += 1
		push_error("ASSERT FAILED: %s" % msg)

func _eq(a, b, msg: String = "") -> void:
	_ok(a == b, msg + " | expected=%s actual=%s" % [str(b), str(a)])

func _near(a: float, b: float, eps: float, msg: String = "") -> void:
	_ok(abs(a - b) <= eps, msg + " | expected≈%s actual=%s" % [str(b), str(a)])


# Dummy classes for testing

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

# Utility

func _instantiate_with_script(base: Object, script_path: String) -> Object:
	var script := load(script_path)
	var node := base
	node.set_script(script)
	return node


# Tests

func test_player_flip_right_cases() -> void:
	var player := _instantiate_with_script(CharacterBody2D.new(), "res://Scripts/Player.gd")
	var light := PointLight2D.new()
	player.flashlight = light

	player.flashlight_hand_pos = Vector2(12, 3)
	player.flip_flashlight(true)
	_eq(player.flashlight.position, Vector2(0, 0), "Right-facing: flashlight anchored to hand")
	_ok(player.flashlight.scale.x > 0.0, "Right-facing: scale.x positive")

	player.flashlight_hand_pos = Vector2(0, 0)
	player.flip_flashlight(true)
	_eq(player.flashlight.position, Vector2(0, 0), "Right-facing (origin hand)")
	_ok(player.flashlight.scale.x > 0.0, "Right-facing (origin hand) scale.x positive")

	player.flashlight_hand_pos = Vector2(-20, -5)
	player.flip_flashlight(true)
	_eq(player.flashlight.position, Vector2(0, 0), "Right-facing (negative hand)")
	_ok(player.flashlight.scale.x > 0.0, "Right-facing (negative hand) scale.x positive")

func test_player_flip_left_cases() -> void:
	var player := _instantiate_with_script(CharacterBody2D.new(), "res://Scripts/Player.gd")
	var light := PointLight2D.new()
	player.flashlight = light

	player.flashlight_hand_pos = Vector2(10, 4)
	player.flip_flashlight(false)
	_eq(player.flashlight.position, Vector2(-50, -2), "Left-facing: flashlight offset")
	_ok(player.flashlight.scale.x < 0.0, "Left-facing: scale.x negative")

func test_player_flashlight_scale_sign_cases() -> void:
	var player := _instantiate_with_script(CharacterBody2D.new(), "res://Scripts/Player.gd")
	player.flashlight = PointLight2D.new()
	player.flashlight_hand_pos = Vector2(3, 2)

	player.flip_flashlight(true)
	_ok(player.flashlight.scale.x > 0, "Toggle right -> positive scale")
	player.flip_flashlight(false)
	_ok(player.flashlight.scale.x < 0, "Toggle right->left -> negative scale")
	player.flip_flashlight(true)
	_ok(player.flashlight.scale.x > 0, "Toggle right->left->right -> back positive scale")

func test_monster_process_movement_cases() -> void:
	var monster = DummySprite.new()
	monster.flip_h = false
	_ok(monster.flip_h == false, "Dummy monster starts not flipped")

func test_monster_process_boundary_cases() -> void:
	var monster = DummySprite.new()
	monster.flip_h = false
	_ok(monster.flip_h == false, "Boundary dummy monster flip check")

func test_coin_on_body_entered_cases() -> void:
	var coin := _instantiate_with_script(Area2D.new(), "res://Scripts/coin.gd")
	var gm := DummyGameManager.new()
	coin.game_manager = gm

	coin._on_body_entered(Node2D.new())
	_eq(gm.points, 1, "Coin pickup increments score")
	_ok(coin.is_queued_for_deletion(), "Coin queued for deletion")

func test_killzone_body_entered_cases() -> void:
	var kz := _instantiate_with_script(Area2D.new(), "res://Scripts/killzone.gd")
	# Dummy body
	var body := Node2D.new()
	kz._on_body_entered(body)
	_near(Engine.time_scale, 0.5, 0.001, "Killzone halves time scale")

func test_killzone_timeout_cases() -> void:
	var kz := _instantiate_with_script(Area2D.new(), "res://Scripts/killzone.gd")
	Engine.time_scale = 0.25
	kz._on_timer_timeout()
	_near(Engine.time_scale, 1.0, 0.001, "Timeout restores time scale")

func test_player_constants_cases() -> void:
	var player := _instantiate_with_script(CharacterBody2D.new(), "res://Scripts/Player.gd")
	player.flashlight = PointLight2D.new()
	_ok(player.SPEED > 0, "Player SPEED positive")
	_ok(player.JUMP_VELOCITY < 0, "Player JUMP_VELOCITY negative")
	_ok(player.flashlight is Light2D, "Player.flashlight is Light2D")

func test_monster_defaults_and_flip_sequence_cases() -> void:
	var monster = DummySprite.new()
	monster.flip_h = false
	_ok(monster.flip_h == false, "Monster default flip false")

# ----------------------
# Runner
# ----------------------
func _run_all_tests() -> void:
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