extends Node
class_name Stopwatch

var time = 240
var stopped = false

func _process(delta: float) -> void:
	if stopped:
		return
	time -= delta
	if(time <= 0):
		get_tree().change_scene_to_file("res://Scenes/menu_lost.tscn")
	
func reset():
	time = 300
	
func time_to_string() -> String:
	#Turn the time var into a string for UI display
	var msec = fmod(time,1) * 1000
	var sec = fmod(time, 60)
	var min = time / 60
	var format_string = "%02d : %02d"
	var actual_string = format_string % [min, sec]
	return actual_string

func get_time():
	return time
