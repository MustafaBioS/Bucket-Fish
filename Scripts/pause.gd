extends CanvasLayer


func _on_resume_pressed() -> void:
	State.paused = false
	
func _on_options_pressed() -> void:
	pass # Replace with function body.

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
