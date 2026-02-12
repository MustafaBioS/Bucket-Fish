extends CharacterBody2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()


func _on_pickup_area_body_entered(body: Node2D) -> void:
	State.score += 1
	print(State.score)
	queue_free()
