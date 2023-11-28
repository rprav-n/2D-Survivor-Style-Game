class_name BasicEnemy

extends CharacterBody2D

const MAX_SPEED: int = 40

var player: Player = null
@onready var health_component: HealthComponent = $HealthComponent


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player") as Player


func _process(_delta: float) -> void:
	var direction: Vector2 = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_direction_to_player() -> Vector2:
	var direction: Vector2 = Vector2.ZERO
	if !is_instance_valid(player):
		return direction
	
	direction = (player.global_position - global_position).normalized()
	return direction
	
