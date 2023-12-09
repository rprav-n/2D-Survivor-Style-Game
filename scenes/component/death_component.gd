class_name DeathComponent

extends Node2D

@export var health_component: HealthComponent
@export var sprite: Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D


func _ready() -> void:
	gpu_particles_2d.texture = sprite.texture
	health_component.died.connect(_on_died)
	

func _on_died() -> void:
	if owner == null:
		return
	var spawn_position: Vector2 = owner.global_position
	var entities: Node2D = get_tree().get_first_node_in_group("entities_layer") as Node2D
	get_parent().remove_child(self)
	entities.add_child(self)
	global_position = spawn_position
	animation_player.play("default")
