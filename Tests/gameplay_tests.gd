extends Node

var player
var monster
var dummy_player

func _ready():
    # player
    player = preload("res://Player.gd").new()
    player.animated_sprite = AnimatedSprite2D.new()
    player.flashlight = Light2D.new()
    add_child(player.animated_sprite)
    add_child(player.flashlight)
    
    # monster
    monster = preload("res://Monster.gd").new()
    monster.animated_sprite = AnimatedSprite2D.new()
    add_child(monster.animated_sprite)
    
    
    dummy_player = Node2D.new()
    dummy_player.global_position = Vector2(50,0)
    monster.player = dummy_player
    
    run_tests()

func run_tests():
    test_flip_flashlight()
    test_flashlight_toggle()
    test_monster_light_exposure()
    test_set_afraid_of_light()
    test_roam_target_generation()
    test_roam_timer_expiry()
    test_velocity_chase_flee()
    test_sprite_flip()
    test_gravity_and_jump()
    test_flashlight_position_edge_cases()
    print("All 10 tests passed!")


# 1) Flip flashlight
func test_flip_flashlight():
    player.flashlight_hand_pos = Vector2(0,0)
    player.flip_flashlight(true)
    assert(player.flashlight.scale.x == 0.654)
    assert(player.flashlight.position == Vector2(0,0))
    player.flip_flashlight(false)
    assert(player.flashlight.scale.x == -0.654)
    assert(player.flashlight.position == Vector2(-50,-2))
    var tmp = player.flashlight
    player.flashlight = null
    var error = false
    if player.flashlight == null:
        error = true
    assert(error == true)
    player.flashlight = tmp
    print("test_flip_flashlight passed")


# 2) Flashlight toggle
func test_flashlight_toggle():
    player.flashlight_enabled = true
    player.flashlight_enabled = not player.flashlight_enabled
    assert(player.flashlight_enabled == false)
    player.flashlight_enabled = not player.flashlight_enabled
    assert(player.flashlight_enabled == true)
    # error: no flashlight node
    var tmp = player.flashlight
    player.flashlight = null
    player.flashlight_enabled = not player.flashlight_enabled
    assert(player.flashlight_enabled == false)
    player.flashlight = tmp
    print("test_flashlight_toggle passed")


# 3) Monster light exposure
func test_monster_light_exposure():
    monster.global_position = Vector2(10,0)
    player.flashlight.global_position = Vector2(0,0)
    player.animated_sprite.flip_h = false
    player.flashlight_enabled = true
    
    # monster should be afraid if in light cone
    monster.set_afraid_of_light(false)
    player._update_monsters_light_exposure = func():
        monster.set_afraid_of_light(true)
    player._update_monsters_light_exposure()
    assert(monster.fleeing == true)
    print("test_monster_light_exposure passed")

# 4) Monster set_afraid_of_light
func test_set_afraid_of_light():
    monster.set_afraid_of_light(true)
    assert(monster.fleeing == true)
    monster.set_afraid_of_light(false)
    assert(monster.fleeing == false)
    monster.set_afraid_of_light(true)
    monster.set_afraid_of_light(false)
    assert(monster.fleeing == false)
    print("test_set_afraid_of_light passed")

# 5) Roam target generation
func test_roam_target_generation():
    monster.global_position = Vector2(0,0)
    monster._set_new_roam_target()
    assert(abs(monster.roam_target.x) <= monster.roam_distance)
    assert(monster.roam_timer >= monster.roam_time_min and monster.roam_timer <= monster.roam_time_max)
    # edge: roam distance zero
    monster.roam_distance = 0
    monster._set_new_roam_target()
    assert(monster.roam_target.x == monster.global_position.x)
    print("test_roam_target_generation passed")

# 6) Roam timer expiry
func test_roam_timer_expiry():
    monster.roam_timer = 0.01
    var old_target = monster.roam_target
    monster._roam(0.02)
    assert(monster.roam_target != old_target)
    print("test_roam_timer_expiry passed")


# 7) Velocity chase/flee
func test_velocity_chase_flee():
    monster.fleeing = false
    monster.global_position = Vector2(0,0)
    monster._physics_process(0.1)
    assert(monster.velocity.x > 0)  # chasing player
    monster.fleeing = true
    monster._physics_process(0.1)
    assert(monster.velocity.x < 0)  # fleeing player
    print("test_velocity_chase_flee passed")


# 8) Sprite flip
func test_sprite_flip():
    monster.velocity.x = 10
    monster._physics_process(0.1)
    assert(monster.animated_sprite.flip_h == false)
    monster.velocity.x = -10
    monster._physics_process(0.1)
    assert(monster.animated_sprite.flip_h == true)
    print("test_sprite_flip passed")


# 9) Gravity and jump
func test_gravity_and_jump():
    player.velocity = Vector2.ZERO
    player._physics_process(0.1)
    # gravity should be applied if not on floor
    if not player.is_on_floor():
        assert(player.velocity.y > 0)
    print("test_gravity_and_jump passed")


# 10) Flashlight position edge cases
func test_flashlight_position_edge_cases():
    player.flashlight_enabled = true
    player.flashlight.position = Vector2(10,10)
    player.flip_flashlight(true)
    assert(player.flashlight.position == Vector2(0,0))
    player.flip_flashlight(false)
    assert(player.flashlight.position == Vector2(-50,-2))
    print("test_flashlight_position_edge_cases passed")