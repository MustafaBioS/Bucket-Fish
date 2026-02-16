extends CanvasLayer
@onready var score: Label = $Score
	
func _process(delta: float) -> void:
	if score != null:
		score.text = "Score: " + str(State.score)
