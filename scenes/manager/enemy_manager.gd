class_name EnemyManager

extends Node

const SPAWN_RADIUS: int = 375

@export var basic_enemy_scene: PackedScene
@onready var timer: Timer = $Timer

var player: Player = null

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	timer.timeout.connect(_on_timer_timeout)


func spawn_enemy() -> void:
	var random_direction: Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position: Vector2 = player.global_position + (random_direction * SPAWN_RADIUS)

	var enemy: CharacterBody2D = basic_enemy_scene.instantiate() as CharacterBody2D
	get_parent().add_child(enemy)
	enemy.global_position = spawn_position


func _on_timer_timeout() -> void:
	if !is_instance_valid(player):
		return
	spawn_enemy()
