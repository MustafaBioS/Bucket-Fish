extends CharacterBody2D
@onready var pause = $"../Pause"
@onready var heartsBox = $"../HUD/Hearts"
var hearts

const SPEED = 500.0
const JUMP_VELOCITY = -400.0

func player():
	pass
	
func _ready() -> void:
	State.paused = false
	hearts = heartsBox.get_children()

func _physics_process(delta: float) -> void:
	
	if State.take_dmg == true:
		for i in range(len(hearts)):
			if i < State.health:
				hearts[i].modulate = Color(1,1,1)
			else:
				hearts[i].modulate = Color(0,0,0)
		# Play Hit SFX
	
	if State.health <= 0:
		get_tree().quit()
		# Better "Death"
	
	if State.paused == false:
		pause.visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif State.paused == true:
		pause.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	var direction := Input.get_axis("a", "d")
	if direction && State.paused == false:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if State.paused == false:
		move_and_slide()
	
	if Input.is_action_just_pressed("pause"):
		if State.paused == true:
			State.paused = false
		elif State.paused == false:
			State.paused = true
