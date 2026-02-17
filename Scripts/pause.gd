extends CanvasLayer
@onready var anim = $"../AnimationPlayer"
var clicked = false

func _on_resume_pressed() -> void:
	if State.transitioning == false:
		State.paused = false
	
func _on_options_pressed() -> void:
	if State.transitioning == false:
		pass # Replace with function body.

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
