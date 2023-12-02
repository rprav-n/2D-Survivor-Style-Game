class_name EnemyManager

extends Node

const SPAWN_RADIUS: int = 375

@export var basic_enemy_scene: PackedScene
@onready var timer: Timer = $Timer

var player: Player = null
var entities_layer: Node2D = null

func _ready() -> void:
	entities_layer = get_tree().get_first_node_in_group("entities_layer")
	player = get_tree().get_first_node_in_group("player")
	timer.timeout.connect(_on_timer_timeout)


func spawn_enemy() -> void:
	if !is_instance_valid(entities_layer):
		return
	var random_direction: Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position: Vector2 = player.global_position + (random_direction * SPAWN_RADIUS)

	var enemy: CharacterBody2D = basic_enemy_scene.instantiate() as CharacterBody2D
	entities_layer.add_child(enemy)
	enemy.global_position = spawn_position


func _on_timer_timeout() -> void:
	if !is_instance_valid(player):
		return
	spawn_enemy()
