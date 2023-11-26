class_name Player

extends CharacterBody2D

const MAX_SPEED: int = 200


func _process(_delta: float) -> void:
	var movement_vector: Vector2 = get_movement_vector()
	var direction: Vector2 = movement_vector.normalized()
	
	velocity = direction * MAX_SPEED
	
	move_and_slide()


func get_movement_vector() -> Vector2:
	var x_movement: float = Input.get_axis("move_left", "move_right")
	var y_movement: float = Input.get_axis("move_up", "move_down")
	return Vector2(x_movement, y_movement)
