extends CharacterBody2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	
	if position.y > 1000:
		queue_free()

func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		State.score += 1
		print(State.score)
		queue_free()
