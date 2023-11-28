class_name ExpirenceManager

extends Node

signal expirence_updated(current_experience: float, target_experience: float)

const TARGET_EXPERIENCE_GROWTH: int = 5

var current_expirence: float = 0
var current_level: int = 1
var target_experience: float = 5


func _ready() -> void:
	GameEvents.experience_vial_collected.connect(_on_experience_vial_collected)


func increment_expirence(number: float) -> void:
	current_expirence = min(current_expirence + number, target_experience)
	expirence_updated.emit(current_expirence, target_experience)
	if current_expirence == target_experience:
		current_level += 1
		target_experience += TARGET_EXPERIENCE_GROWTH
		current_expirence = 0
		expirence_updated.emit(current_expirence, target_experience)


func _on_experience_vial_collected(number: float) -> void:
	increment_expirence(number)
