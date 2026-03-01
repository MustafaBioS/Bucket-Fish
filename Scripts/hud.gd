extends CanvasLayer
@onready var score: Label = $Score
	
func _process(_delta: float) -> void:
	if score != null:
		score.text = "Score: " + str(State.score)
