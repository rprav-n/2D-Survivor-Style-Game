class_name ExperienceBar

extends CanvasLayer

@export var experience_manager: ExpirenceManager
@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar



func _ready() -> void:
	progress_bar.value = 0.0
	experience_manager.expirence_updated.connect(_on_expirence_updated)


func _on_expirence_updated(current_expirence: float, target_expirence: float) -> void:
	var percent: float = current_expirence / target_expirence
	progress_bar.value = percent
