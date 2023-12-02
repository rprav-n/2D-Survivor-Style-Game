class_name Player

extends CharacterBody2D

const MAX_SPEED: int = 150
const ACCELERATION_SMOOTHING: int = 20
@onready var collision_area: Area2D = $CollisionArea
@onready var health_component: HealthComponent = $HealthComponent
@onready var damager_interval_timer: Timer = $DamagerIntervalTimer
@onready var health_bar: ProgressBar = $HealthBar

var no_of_colliding_bodies: int = 0

func _ready() -> void:
	collision_area.body_entered.connect(_on_body_entered)
	collision_area.body_exited.connect(_on_body_exited)
	damager_interval_timer.timeout.connect(_on_damager_interval_timer_timeout)
	health_component.health_changed.connect(_on_health_changed)
	update_health_display()

func _process(delta: float) -> void:
	var movement_vector: Vector2 = get_movement_vector()
	var direction: Vector2 = movement_vector.normalized()
	var target_velocity: Vector2 = direction * MAX_SPEED
	
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-ACCELERATION_SMOOTHING * delta))
	
	move_and_slide()


func check_deal_damage() -> void:
	if no_of_colliding_bodies == 0 || !damager_interval_timer.is_stopped():
		return
	health_component.damage(1)
	damager_interval_timer.start()


func get_movement_vector() -> Vector2:
	var x_movement: float = Input.get_axis("move_left", "move_right")
	var y_movement: float = Input.get_axis("move_up", "move_down")
	return Vector2(x_movement, y_movement)


func update_health_display() -> void:
	health_bar.value = health_component.get_health_percent()


func _on_body_entered(_body: Node2D) -> void:
	no_of_colliding_bodies += 1
	check_deal_damage()


func _on_body_exited(_body: Node2D) -> void:
	no_of_colliding_bodies -= 1
	damager_interval_timer.stop()


func _on_damager_interval_timer_timeout() -> void:
	check_deal_damage()


func _on_health_changed() -> void:
	update_health_display()
