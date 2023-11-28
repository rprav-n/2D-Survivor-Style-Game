class_name Player

extends CharacterBody2D

const MAX_SPEED: int = 150
const ACCELERATION_SMOOTHING: int = 20

func _process(delta: float) -> void:
	var movement_vector: Vector2 = get_movement_vector()
	var direction: Vector2 = movement_vector.normalized()
	var target_velocity: Vector2 = direction * MAX_SPEED
	
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-ACCELERATION_SMOOTHING * delta))
	
	move_and_slide()


func get_movement_vector() -> Vector2:
	var x_movement: float = Input.get_axis("move_left", "move_right")
	var y_movement: float = Input.get_axis("move_up", "move_down")
	return Vector2(x_movement, y_movement)
