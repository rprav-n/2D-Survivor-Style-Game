class_name ArenaTimerUI

extends CanvasLayer

@export var arena_time_manager: ArenaTimeManager
@onready var time_label: Label = %TimeLabel


func _process(_delta: float) -> void:
	if !is_instance_valid(arena_time_manager):
		return
	var time_elapsed: float = arena_time_manager.get_time_elapsed()
	time_label.text = format_seconds_to_string(time_elapsed)


func format_seconds_to_string(seconds: float) -> String:
	var minutes: int = floor(seconds / 60)
	var remaining_seconds: int = floor(seconds - (minutes * 60))
	return str(minutes, ":", ("%02d" % remaining_seconds))
