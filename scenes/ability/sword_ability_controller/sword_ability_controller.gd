class_name SwordAbilityController

extends Node

@export var sword_ability_scene: PackedScene

@onready var timer: Timer = $Timer

var player: Player = null

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player") as Player
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	if !is_instance_valid(player):
		return
	
	var sword_ability: SwordAbility = sword_ability_scene.instantiate() as SwordAbility
	player.get_parent().add_child(sword_ability)
	sword_ability.global_position = player.global_position
