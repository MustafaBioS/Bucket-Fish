extends CanvasLayer
@onready var anim = $"../AnimationPlayer"
var clicked = false
@onready var options = $OptionsPanel
@onready var audioCon = $OptionsPanel/AudioCon
@onready var screenCon = $OptionsPanel/ScreenCon

func _ready() -> void:
	options.visible = false
	audioCon.visible = true
	screenCon.visible = false
	

func _on_resume_pressed() -> void:
	if State.transitioning == false:
		State.paused = false
	
func _on_options_pressed() -> void:
	if State.transitioning == false and State.paused == true:
		options.visible = true

func _on_audio_pressed() -> void:
	audioCon.visible = true
	screenCon.visible = false
	
func _on_screen_pressed() -> void:
	screenCon.visible = true
	audioCon.visible = false
	
func _on_back_pressed() -> void:
	options.visible = false

func _on_menu_pressed() -> void:
	State.transitioning = true
	
	if clicked:
		State.transitioning = false
		return
		
	clicked = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	anim.play("fade_out")
	await anim.animation_finished
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	State.transitioning = false

func _on_exit_pressed() -> void:
	if State.transitioning == false:
		get_tree().quit()
