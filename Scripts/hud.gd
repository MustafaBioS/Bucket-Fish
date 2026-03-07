extends CanvasLayer
@onready var score: Label = $Score
@onready var coins = $Coins

func _process(_delta: float) -> void:
	if score != null:
		score.text = "Score: " + str(State.score)
	
	if coins != null:
		coins.text = str(State.coins) + "[img=50x50]res://Assets/coin.png[/img]"
