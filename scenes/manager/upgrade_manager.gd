class_name UpgradeManager

extends Node

@export var experience_manager: ExpirenceManager
@export var upgrade_pool: Array[AbilityUpgrade]

var current_upgrades: Dictionary = {}


func _ready() -> void:
	experience_manager.level_up.connect(_on_level_up)


func _on_level_up(current_level: int) -> void:
	var chosen_upgrade: AbilityUpgrade = upgrade_pool.pick_random()
	if chosen_upgrade == null:
		return
	
	var has_upgrade: bool = current_upgrades.has(chosen_upgrade.id)
	if !has_upgrade:
		current_upgrades[chosen_upgrade.id] = {
			"resource": chosen_upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[chosen_upgrade.id]["quantity"] += 1
		
