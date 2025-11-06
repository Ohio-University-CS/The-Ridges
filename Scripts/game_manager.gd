extends Node

# --- Score tracking ---
var score: int = 0
@export var notes_to_win: int = 10 #amount of nodes   

func _ready() -> void:
	print("Game Manager ready! Collect ", notes_to_win, " notes to win.")

# Call this whenever a note is collected
func add_score(amount: int = 1) -> void:
	score += amount
	print("Score: ", score, "/", notes_to_win)
	_check_win_condition()

# Check if the player has won
func _check_win_condition() -> void:
	if score >= notes_to_win:
		print("You collected all notes! You Win!")
		
