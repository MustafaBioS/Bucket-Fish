extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -400.0

func player():
	pass

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("a", "d")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_timer_timeout() -> void:
	print(global_position)
