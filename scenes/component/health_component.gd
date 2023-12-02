class_name HealthComponent

extends Node

signal died
signal health_changed

@export var max_health: float = 10
var current_health: float


func _ready() -> void:
	current_health = max_health


func damage(amount: float) -> void:
	current_health = max(current_health - amount, 0)
	health_changed.emit()
	Callable(check_death).call_deferred()


func check_death() -> void:
	if current_health == 0:
		died.emit()
		owner.queue_free()


func get_health_percent() -> float:
	if max_health <= 0:
		return 0.0
	return min(current_health / max_health, 1)
