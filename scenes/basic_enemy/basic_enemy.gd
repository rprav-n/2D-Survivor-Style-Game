class_name BasicEnemy

extends CharacterBody2D

const MAX_SPEED: int = 100

var player: Player = null
@onready var hurtbox: Area2D = $Hurtbox


func _ready() -> void:
	hurtbox.area_entered.connect(_on_hurtbox_area_entered)
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
	

func _on_hurtbox_area_entered(_area: Area2D) -> void:
	queue_free()
