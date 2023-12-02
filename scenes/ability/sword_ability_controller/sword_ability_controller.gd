class_name SwordAbilityController

extends Node

const MAX_RANGE: int = 150

@export var sword_ability_scene: PackedScene
var damage: int = 5
var base_wait_time: float
@onready var timer: Timer = $Timer

var player: Player = null

func _ready() -> void:
	base_wait_time = timer.wait_time
	player = get_tree().get_first_node_in_group("player") as Player
	timer.timeout.connect(_on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(_on_ability_upgrade_added)


func spawn_sword_ability() -> void:
	var first_enemy: Node2D = get_first_enemy()
	if first_enemy == null:
		return
		
	var sword_ability: SwordAbility = sword_ability_scene.instantiate() as SwordAbility
	
	get_tree().current_scene.add_child(sword_ability)
	sword_ability.hitbox_component.damage = damage
	sword_ability.global_position = first_enemy.global_position
	sword_ability.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4

	var enemy_direction = first_enemy.global_position - sword_ability.global_position
	sword_ability.rotation = enemy_direction.angle()
	

func get_first_enemy() -> Node2D:
	var enemies: Array[Node] = get_tree().get_nodes_in_group("enemy") as Array[Node]
	enemies = enemies.filter(
		func(enemy: Node):
			return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	if enemies.size() == 0:
		return null
	
	enemies.sort_custom(
		func(a: Node2D, b: Node2D):
			var a_to_player_distance: float = a.global_position.distance_squared_to(player.global_position)
			var b_to_player_distance: float = b.global_position.distance_squared_to(player.global_position)
			return a_to_player_distance < b_to_player_distance
	)
	
	var enemy: Node2D = enemies[0] as Node2D
	
	return enemy


func _on_timer_timeout() -> void:
	if !is_instance_valid(player):
		return
	
	spawn_sword_ability()


func _on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if upgrade.id != "sword_rate":
		return
	
	var percent_redcution: float = current_upgrades["sword_rate"]["quantity"] * 0.1
	timer.wait_time = base_wait_time * (1 - percent_redcution)
	timer.start()
	
