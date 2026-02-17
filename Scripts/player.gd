extends CharacterBody2D
@onready var pause = $"../Pause"
@onready var heartsBox = $"../HUD/Hearts"
var hearts
@onready var anim = $"../AnimationPlayer"

const SPEED = 500.0
const JUMP_VELOCITY = -400.0

signal died
var is_dead = false

func player():
	pass
	
func _ready() -> void:
	State.paused = false
	hearts = heartsBox.get_children()
	anim.play("fade_in")
	await anim.animation_finished

	State.transitioning = false
	State.score = 0
	State.health = 3
	State.paused = false
	State.take_dmg = false

func _physics_process(delta: float) -> void:
	
	if State.take_dmg == true:
		for i in range(len(hearts)):
			if i < State.health:
				hearts[i].modulate = Color(1,1,1)
			else:
				hearts[i].modulate = Color(0,0,0)
		# Play Hit SFX
	
	if State.health <= 0 and not is_dead:
		is_dead = true
		anim.play("death")
		await anim.animation_finished
		emit_signal("died")

		# add a restart/main menu options scene
	
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
	
	if Input.is_action_just_pressed("pause") and State.transitioning == false:
		if State.paused == true:
			State.paused = false
		elif State.paused == false:
			State.paused = true

func _on_died() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
