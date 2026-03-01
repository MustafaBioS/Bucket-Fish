extends CharacterBody2D
@export var item_type: String = "fish"

var hearts : Array = []

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor() and State.paused == false:
		velocity += get_gravity() * delta
 
	if State.paused == false:
		move_and_slide()
	
	if position.y > 500:
		State.health -= 1
		State.take_dmg = true
		queue_free()

func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if item_type == "coin":
			State.coins += 1
			print(State.coins)
		else:
			State.score += 1
			print(State.score)
		queue_free()
