class_name SwordAbilityController

extends Node

const MAX_RANGE: int = 150

@export var sword_ability_scene: PackedScene

@onready var timer: Timer = $Timer

var player: Player = null

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player") as Player
	timer.timeout.connect(_on_timer_timeout)


func spawn_sword_ability() -> void:
	var enemies: Array[Node] = get_tree().get_nodes_in_group("enemy") as Array[Node]
	enemies = enemies.filter(
		func(enemy: Node):
			return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	if enemies.size() == 0:
		return
	
	enemies.sort_custom(
		func(a: Node2D, b: Node2D):
			var a_to_player_distance: float = a.global_position.distance_squared_to(player.global_position)
			var b_to_player_distance: float = b.global_position.distance_squared_to(player.global_position)
			return a_to_player_distance < b_to_player_distance
	)
	
	var enemy: Node2D = enemies[0] as Node2D
	
	var sword_ability: SwordAbility = sword_ability_scene.instantiate() as SwordAbility
	get_tree().current_scene.add_child(sword_ability)
	sword_ability.global_position = enemy.global_position

func _on_timer_timeout() -> void:
	if !is_instance_valid(player):
		return
	
	spawn_sword_ability()
