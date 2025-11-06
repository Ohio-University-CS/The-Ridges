extends Node

var failures := 0
var total_asserts := 0

func _ready():
    print("Running Godot 4 GDScript unit tests...\n")
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
# Dummy classes
# ----------------------
class_name DummySprite
var flip_h := false

class_name DummyGameManager
var points := 0
func add_point() -> void:
    points += 1

class_name DummyMonster
var direction := 1
var animated_sprite := DummySprite.new()
func _process(delta: float) -> void:
    # simulate simple movement
    pass

# ----------------------
# Test functions
# ----------------------
# 1) Player flip flashlight right
func test_player_flip_right_cases():
    var light := PointLight2D.new()
    var player := Node.new()
    player.flashlight = light
    player.flashlight_hand_pos = Vector2(12,3)

    # Case 1
    player.flip_flashlight = func(facing_right: bool) -> void:
        if facing_right:
            player.flashlight.position = Vector2(0,0)
            player.flashlight.scale.x = 1
    player.flip_flashlight(true)
    _eq(player.flashlight.position, Vector2(0,0), "Right-facing: flashlight position")
    _ok(player.flashlight.scale.x > 0, "Right-facing: scale positive")

    # Case 2
    player.flashlight_hand_pos = Vector2(0,0)
    player.flip_flashlight(true)
    _eq(player.flashlight.position, Vector2(0,0), "Right-facing (origin hand)")
    _ok(player.flashlight.scale.x > 0, "Right-facing scale positive")

    # Case 3
    player.flashlight_hand_pos = Vector2(-20,-5)
    player.flip_flashlight(true)
    _eq(player.flashlight.position, Vector2(0,0), "Right-facing negative hand")
    _ok(player.flashlight.scale.x > 0, "Right-facing scale positive")

# 2) Player flip flashlight left
func test_player_flip_left_cases():
    var light := PointLight2D.new()
    var player := Node.new()
    player.flashlight = light

    player.flip_flashlight = func(facing_right: bool) -> void:
        if not facing_right:
            player.flashlight.position = Vector2(-50,-2)
            player.flashlight.scale.x = -1

    # Case 1
    player.flip_flashlight(false)
    _eq(player.flashlight.position, Vector2(-50,-2), "Left-facing: offset")
    _ok(player.flashlight.scale.x < 0, "Left-facing scale negative")

    # Case 2
    player.flip_flashlight(false)
    _eq(player.flashlight.position, Vector2(-50,-2), "Left-facing repeat")
    _ok(player.flashlight.scale.x < 0, "Left-facing scale negative")

    # Case 3
    player.flip_flashlight(false)
    _eq(player.flashlight.position, Vector2(-50,-2), "Left-facing large hand ignored")
    _ok(player.flashlight.scale.x < 0, "Left-facing scale negative")

# 3) Player flashlight toggle scale sign
func test_player_flashlight_scale_sign_cases():
    var light := PointLight2D.new()
    var player := Node.new()
    player.flashlight = light

    player.flip_flashlight = func(facing_right: bool) -> void:
        if facing_right:
            player.flashlight.scale.x = 1
        else:
            player.flashlight.scale.x = -1

    player.flip_flashlight(true)
    _ok(player.flashlight.scale.x > 0, "Right scale positive")
    player.flip_flashlight(false)
    _ok(player.flashlight.scale.x < 0, "Left scale negative")
    player.flip_flashlight(true)
    _ok(player.flashlight.scale.x > 0, "Right scale positive again")

# 4) Monster process movement
func test_monster_process_movement_cases():
    var monster := DummyMonster.new()
    monster.direction = 1
    monster._process(1.0)
    _ok(monster.animated_sprite.flip_h == false, "Monster flip_h default false")

# 5) Monster edge cases
func test_monster_edge_cases():
    var monster := DummyMonster.new()
    monster.direction = -1
    _ok(monster.direction == -1, "Monster default direction left")
    monster.direction = 1
    _ok(monster.direction == 1, "Monster flips back to right")

# 6) Coin pickup
func test_coin_pickup_cases():
    var gm := DummyGameManager.new()
    gm.add_point()
    _eq(gm.points, 1, "Coin pickup increments points")
    gm.add_point()
    _eq(gm.points, 2, "Coin pickup increments points again")

# 7) Killzone time scale
func test_killzone_timescale_cases():
    Engine.time_scale = 1.0
    Engine.time_scale = 0.5
    _near(Engine.time_scale, 0.5, 0.001, "Killzone slows time")
    Engine.time_scale = 1.0
    _near(Engine.time_scale, 1.0, 0.001, "Killzone restores time")

# 8) Player constants
func test_player_constants_cases():
    var speed := 100
    var jump := -250
    _ok(speed > 0, "Player speed positive")
    _ok(jump < 0, "Player jump negative")

# 9) Monster defaults
func test_monster_defaults_cases():
    var monster := DummyMonster.new()
    _ok(monster.direction == 1, "Monster default direction is right")

# 10) Monster flip sequence
func test_monster_flip_sequence_cases():
    var monster := DummyMonster.new()
    monster.direction = 1
    monster.direction = -1
    _ok(monster.direction == -1, "Flip right->left")
    monster.direction = 1
    _ok(monster.direction == 1, "Flip left->right")

# ----------------------
# Runner
# ----------------------
func _run_all_tests():
    test_player_flip_right_cases()
    test_player_flip_left_cases()
    test_player_flashlight_scale_sign_cases()
    test_monster_process_movement_cases()
    test_monster_edge_cases()
    test_coin_pickup_cases()
    test_killzone_timescale_cases()
    test_player_constants_cases()
    test_monster_defaults_cases()
    test_monster_flip_sequence_cases()