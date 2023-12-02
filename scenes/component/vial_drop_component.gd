class_name VialDropComponent

extends Node

@export_range(0, 1) var drop_percent: float = 0.5
@export var health_component: HealthComponent
@export var experience_vial_scene: PackedScene
var entities_layer: Node2D = null

func _ready() -> void:
	entities_layer = get_tree().get_first_node_in_group("entities_layer")
	health_component.died.connect(_on_died)


func spawn_experience_vial() -> void:
	if !is_instance_valid(entities_layer):
		return
	var spawn_position: Vector2 = (owner as Node2D).global_position
	var experience_vial: ExperienceVial = experience_vial_scene.instantiate() as ExperienceVial
	entities_layer.add_child(experience_vial)
	experience_vial.global_position = spawn_position


func _on_died() -> void:
	if randf() > drop_percent or experience_vial_scene == null or (not owner is Node2D):
		return
	
	spawn_experience_vial()
