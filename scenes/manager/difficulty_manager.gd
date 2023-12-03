class_name DifficultyManager

extends Node

signal difficulty_increase(difficulty: int)

var difficulty: int = 0
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	timer.wait_time = timer.wait_time * 2
	timer.start()
	difficulty += 1
	difficulty_increase.emit(difficulty)
	
