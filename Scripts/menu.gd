extends Control
@onready var options = $OptionsPanel

func _ready() -> void:
	options.visible = false

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_2_pressed() -> void:
	options.visible = true
	
func _on_button_3_pressed() -> void:
	get_tree().quit()

func _on_back_pressed() -> void:
	options.visible = false
