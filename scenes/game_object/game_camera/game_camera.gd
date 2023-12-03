class_name GameCamera

extends Camera2D

const SMOOTHING: int = 20

@export var background_color: Color

var player: Player = null
var target_position: Vector2 = Vector2.ZERO


func _ready() -> void:
	RenderingServer.set_default_clear_color(background_color)
	make_current()
	player = get_tree().get_first_node_in_group("player") as Player


func _process(delta: float) -> void:
	acquire_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-SMOOTHING * delta))


func acquire_target():
	if is_instance_valid(player):
		target_position = player.global_position
