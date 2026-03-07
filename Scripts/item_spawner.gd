extends Node2D

var spawn_pos = null
const fish = preload("uid://drpsa7awte0bg")
const coin = preload("uid://dxswmquq2ij0l")


@onready var left_marker = $LeftMarker
@onready var right_marker = $RightMarker

func _ready() -> void:
	if State.paused == false and State.is_dead == false:
		randomize()
	
func spawn():
	if State.paused == false:
		var roll = randf()
		var scene
		if roll < 0.85:
			scene = fish
		else:
			scene = coin
		
		var obj = scene.instantiate()
		
		var min_x = min(left_marker.global_position.x, right_marker.global_position.x)
		var max_x = max(left_marker.global_position.x, right_marker.global_position.x)
		var spawn_x = randf_range(min_x, max_x)

		var spawn_y = left_marker.global_position.y

		print("Set Spawn, min_x: " + str(min_x) + " max_x: " + str(max_x) + " spawn_x: " + str(spawn_x) + "spawn_y: " + str(spawn_y) )

		obj.global_position = Vector2(spawn_x, spawn_y)
		
		print("Set Fish Global Pos: " + str(obj.global_position))

		add_child(obj)
		
		print("Added Child") 

func _on_timer_timeout() -> void:
	if State.paused == false:
		spawn()
