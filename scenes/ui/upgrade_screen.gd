class_name UpgradeScreen

extends CanvasLayer

@export var ability_upgrade_card_scene: PackedScene
@onready var card_container: HBoxContainer = %CardContainer


func _ready() -> void:
	get_tree().paused = true


func set_ability_upgrades(upgrades: Array[AbilityUpgrade]) -> void:
	for upgrade in upgrades:
		var ability_upgrade_card_instance: AbilityUpgradeCard = ability_upgrade_card_scene.instantiate() as AbilityUpgradeCard
		card_container.add_child(ability_upgrade_card_instance)
		ability_upgrade_card_instance.set_ability_upgrade(upgrade)
