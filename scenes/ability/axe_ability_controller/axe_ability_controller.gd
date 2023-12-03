class_name AxeAbilityController

extends Node

@onready var timer: Timer = $Timer
@export var axe_ability_scene: PackedScene

var player: Player = null
var foreground_layer: Node2D = null

var damage: int = 10

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	timer.timeout.connect(_on_timer_timeout)
	

func spawn_axe() -> void:
	var axe_ability_instance: AxeAbility = axe_ability_scene.instantiate() as AxeAbility
	foreground_layer.add_child(axe_ability_instance)
	axe_ability_instance.global_position = player.global_position
	axe_ability_instance.hitbox_component.damage = damage


func _on_timer_timeout() -> void:
	if player == null || foreground_layer == null:
		return
	spawn_axe()
