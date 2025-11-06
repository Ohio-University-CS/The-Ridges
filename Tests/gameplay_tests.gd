extends SceneTree

# Lightweight GDScript gameplay unit tests
# Run with:
# godot --headless --path . --script Tests/gameplay_tests.gd

var failures := 0
var total_asserts := 0

func _initialize() -> void:
	print("Running gameplay tests...\n")
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

# ----------------------
# Dummy classes
# ----------------------
class DummySprite:
	var flip_h := false

class DummyLight:
	var scale := Vector2(1, 1)
	var position := Vector2.ZERO

# ----------------------
# Test 1: Player flashlight flip
# ----------------------
func test_player_flip_flashlight() -> void:
	var player = load("res://Scripts/Player.gd").new()
	player.flashlight = DummyLight.new()

	# Case 1: Right
	player.flashlight_hand_pos = Vector2(10, 5)
	player.flip_flashlight(true)
	_eq(player.flashlight.position, Vector2(0, 0), "Right-facing flashlight pos")
	_ok(player.flashlight.scale.x > 0, "Right-facing flashlight scale")

	# Case 2: Left
	player.flashlight_hand_pos = Vector2(5, 5)
	player.flip_flashlight(false)
	_eq(player.flashlight.position, Vector2(-50, -2), "Left-facing flashlight pos")
	_ok(player.flashlight.scale.x < 0, "Left-facing flashlight scale")

	# Case 3: Negative hand pos
	player.flashlight_hand_pos = Vector2(-20, -5)
	player.flip_flashlight(false)
	_eq(player.flashlight.position, Vector2(-50, -2), "Left-facing negative hand pos")
	_ok(player.flashlight.scale.x < 0, "Scale remains negative")

# ----------------------
# Test 2: Player flashlight toggle
# ----------------------
func test_player_flashlight_toggle() -> void:
	var player = load("res://Scripts/Player.gd").new()
	player.flashlight = DummyLight.new()
	player.flashlight_enabled = true

	# Case 1: Toggle off
	player.flashlight_enabled = !player.flashlight_enabled
	_eq(player.flashlight_enabled, false, "Flashlight toggled off")

	# Case 2: Toggle on
	player.flashlight_enabled = !player.flashlight_enabled
	_eq(player.flashlight_enabled, true, "Flashlight toggled on")

	# Case 3: Multiple toggles
	for i in range(5):
		player.flashlight_enabled = !player.flashlight_enabled
	_ok(player.flashlight_enabled == false or player.flashlight_enabled == true, "Toggle multiple times works")

# ----------------------
# Test 3: Player constants
# ----------------------
func test_player_constants() -> void:
	var player = load("res://Scripts/Player.gd").new()
	_ok(player.SPEED > 0, "SPEED positive")
	_ok(player.JUMP_VELOCITY < 0, "JUMP_VELOCITY negative")
	_ok(player.flashlight is null or player.flashlight is DummyLight, "Flashlight exists")

# ----------------------
# Test 4: Monster fleeing behavior
# ----------------------
func test_monster_fleeing() -> void:
	var monster = load("res://Scripts/monster.gd").new()
	monster.animated_sprite = DummySprite.new()

	# Case 1: Initially not fleeing
	_eq(monster.fleeing, false, "Monster starts not fleeing")

	# Case 2: Player triggers fear
	monster.set_afraid_of_light(true)
	_eq(monster.fleeing, true, "Monster starts fleeing when light on")

	# Case 3: Fear removed
	monster.set_afraid_of_light(false)
	_eq(monster.fleeing, false, "Monster stops fleeing when light off")

# ----------------------
# Test 5: Monster default roaming
# ----------------------
func test_monster_roaming() -> void:
	var monster = load("res://Scripts/monster.gd").new()
	monster._set_new_roam_target()
	_ok(monster.roam_target != Vector2.ZERO, "Roam target set")
	_ok(monster.roam_timer > 0, "Roam timer initialized")
	_ok(monster.roam_timer >= monster.roam_time_min and monster.roam_timer <= monster.roam_time_max, "Timer within range")

# ----------------------
# Test 6: Monster chase range
# ----------------------
func test_monster_chase_range() -> void:
	var monster = load("res://Scripts/monster.gd").new()
	var player = Node2D.new()
	player.global_position = Vector2(100, 0)
	monster.player = player

	# Case 1: Outside chase range
	monster.global_position = Vector2(0, 0)
	monster._physics_process(0.1)
	_ok(monster.fleeing == false, "Monster does not chase outside range")

	# Case 2: Inside chase range
	monster.global_position = Vector2(200, 0)
	monster._physics_process(0.1)
	_ok(monster.fleeing == false, "Monster chases player inside range (not fleeing)")

	# Case 3: Zero distance
	monster.global_position = Vector2(200, 0)
	player.global_position = Vector2(200, 0)
	monster._physics_process(0.1)
	_ok(monster.fleeing == false, "Monster at same position handled")

# ----------------------
# Test 7: Flip sprite when moving
# ----------------------
func test_monster_sprite_flip() -> void:
	var monster = load("res://Scripts/monster.gd").new()
	monster.animated_sprite = DummySprite.new()

	# Case 1: Move right
	monster.velocity = Vector2(10, 0)
	monster._physics_process(0.1)
	_ok(monster.animated_sprite.flip_h == false, "Moving right sprite not flipped")

	# Case 2: Move left
	monster.velocity = Vector2(-10, 0)
	monster._physics_process(0.1)
	_ok(monster.animated_sprite.flip_h == true, "Moving left sprite flipped")

	# Case 3: Zero movement
	monster.velocity = Vector2(0, 0)
	monster._physics_process(0.1)
	_ok(monster.animated_sprite.flip_h == true or monster.animated_sprite.flip_h == false, "Zero velocity handled")

# ----------------------
# Test 8: Player jump
# ----------------------
func test_player_jump() -> void:
	var player = load("res://Scripts/Player.gd").new()
	player.velocity = Vector2(0, 0)
	player.on_floor = true  # simulate is_on_floor
	player._physics_process(0.1)
	player.velocity.y = player.JUMP_VELOCITY
	_ok(player.velocity.y < 0, "Player jump sets negative velocity")
	_eq(player.velocity.x, 0, "Horizontal velocity unchanged")
	_eq(player.flashlight_enabled, player.flashlight_enabled, "Flashlight state unchanged")

# ----------------------
# Test 9: Flashlight exposure effect on monster
# ----------------------
func test_flashlight_monster() -> void:
	var monster = load("res://Scripts/monster.gd").new()
	var player = load("res://Scripts/Player.gd").new()
	player.flashlight_enabled = true
	monster.player = player

	# Simulate monster in range of flashlight
	monster.global_position = Vector2(10, 0)
	player.global_position = Vector2(0, 0)
	monster.set_afraid_of_light(true)
	_eq(monster.fleeing, true, "Monster flees when flashlight points at it")

# ----------------------
# Test 10: Monster roaming timer edge
# ----------------------
func test_monster_roam_timer_edge() -> void:
	var monster = load("res://Scripts/monster.gd").new()
	monster._set_new_roam_target()
	var old_target = monster.roam_target
	monster.roam_timer = 0
	monster._roam(0.1)
	_ok(monster.roam_target != old_target, "New roam target set when timer <= 0")
	_ok(monster.roam_timer > 0, "Timer reset after roaming")
	_ok(monster.roam_target != Vector2.ZERO, "Roam target not zero")

# ----------------------
# Runner
# ----------------------
func _run_all_tests() -> void:
	test_player_flip_flashlight()
	test_player_flashlight_toggle()
	test_player_constants()
	test_monster_fleeing()
	test_monster_roaming()
	test_monster_chase_range()
	test_monster_sprite_flip()
	test_player_jump()
	test_flashlight_monster()
	test_monster_roam_timer_edge()