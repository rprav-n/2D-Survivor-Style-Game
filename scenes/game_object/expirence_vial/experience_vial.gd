class_name ExperienceVial

extends Node2D

@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	area_2d.area_entered.connect(_on_area_2d_area_entered)


func _on_area_2d_area_entered(_area: Area2D) -> void:
	GameEvents.emit_experience_vial_collected(1)
	queue_free()
