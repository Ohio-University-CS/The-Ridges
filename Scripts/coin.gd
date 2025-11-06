extends Area2D


@onready var game_manager = %GameManager


func _ready() -> void:
	# Connect the signal for when something enters the area
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	# Check if the body is in the player group
	if body.is_in_group("player"):
		if game_manager and game_manager.has_method("add_score"):
			game_manager.add_score(1)
		queue_free()  # Remove note from scene
