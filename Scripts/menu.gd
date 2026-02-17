extends Control
@onready var options = $OptionsPanel
@onready var audioCon = $OptionsPanel/AudioCon
@onready var screenCon = $OptionsPanel/ScreenCon
@onready var anim = $AnimationPlayer
var clicked = false

func _ready() -> void:
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	options.visible = false
	
	audioCon.visible = true
	screenCon.visible = false
	
	anim.play("fade_in")
	await anim.animation_finished

	State.transitioning = false
	State.score = 0
	State.health = 3
	State.paused = false
	State.take_dmg = false
	
func _on_button_pressed() -> void:
	State.transitioning = true
	
	if clicked:
		State.transitioning = false
		return
	
	clicked = true
	anim.play("fade_out")
	await anim.animation_finished
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	State.transitioning = false

func _on_button_2_pressed() -> void:
	if State.transitioning == false:
		options.visible = true
	
func _on_button_3_pressed() -> void:
	if State.transitioning == false:
		get_tree().quit()

# Options Panel Buttons

func _on_back_pressed() -> void:
	options.visible = false

func _on_audio_pressed() -> void:
	audioCon.visible = true
	screenCon.visible = false
	
func _on_screen_pressed() -> void:
	screenCon.visible = true
	audioCon.visible = false
