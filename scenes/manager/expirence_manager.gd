class_name ExpirenceManager

extends Node

var current_expirence: float = 0


func _ready() -> void:
	GameEvents.experience_vial_collected.connect(_on_experience_vial_collected)


func increment_expirence(number: float) -> void:
	current_expirence += number
	print(current_expirence)


func _on_experience_vial_collected(number: float) -> void:
	increment_expirence(number)
