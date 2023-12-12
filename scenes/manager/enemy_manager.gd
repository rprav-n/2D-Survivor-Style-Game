class_name EnemyManager

extends Node

const SPAWN_RADIUS: int = 375

@export var basic_enemy_scene: PackedScene
@export var wizard_enemy_scene: PackedScene
@export var difficulty_manager: DifficultyManager
@onready var timer: Timer = $Timer

var player: Player = null
var entities_layer: Node2D = null

var base_spawn_time: float = 0
var enemy_table = WeightedTable.new()

func _ready() -> void:
	enemy_table.add_item(basic_enemy_scene, 10)
	base_spawn_time = timer.wait_time
	entities_layer = get_tree().get_first_node_in_group("entities_layer")
	player = get_tree().get_first_node_in_group("player")
	timer.timeout.connect(_on_timer_timeout)
	difficulty_manager.difficulty_increase.connect(_on_difficulty_increase)


func spawn_enemy() -> void:
	if !is_instance_valid(entities_layer) || !is_instance_valid(player):
		return
	
	var enemy_scene: PackedScene = enemy_table.pick_item()
	var enemy: CharacterBody2D = enemy_scene.instantiate() as CharacterBody2D
	entities_layer.add_child(enemy)
	enemy.global_position = get_spawn_position()


func get_spawn_position() -> Vector2:
	var spawn_position: Vector2 = Vector2.ZERO
	var random_direction: Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))
	for i in 4:
		spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
	
		var query_parameters: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(
			player.global_position, spawn_position, 1
		)
		var result: Dictionary = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)
		if result.is_empty():
			break
		else:
			random_direction = random_direction.rotated(deg_to_rad(90.0))
	
	return spawn_position


func _on_timer_timeout() -> void:
	timer.start()
	if !is_instance_valid(player):
		return
	spawn_enemy()


func _on_difficulty_increase(difficulty: int) -> void:
	var time_off: float = (0.1 / 12) * difficulty
	time_off = min(time_off, 0.7)
	timer.wait_time = base_spawn_time - time_off

	if difficulty == 6:
		enemy_table.add_item(wizard_enemy_scene, 20)
