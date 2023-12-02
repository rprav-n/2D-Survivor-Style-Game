class_name UpgradeScreen

extends CanvasLayer

signal upgrade_selected(upgrade: AbilityUpgrade)

@export var ability_upgrade_card_scene: PackedScene
@onready var card_container: HBoxContainer = %CardContainer


func _ready() -> void:
	get_tree().paused = true


func set_ability_upgrades(upgrades: Array[AbilityUpgrade]) -> void:
	for upgrade in upgrades:
		var ability_upgrade_card_instance: AbilityUpgradeCard = ability_upgrade_card_scene.instantiate() as AbilityUpgradeCard
		card_container.add_child(ability_upgrade_card_instance)
		ability_upgrade_card_instance.set_ability_upgrade(upgrade)
		ability_upgrade_card_instance.selected.connect(_on_upgrade_selected.bind(upgrade))
	

func _on_upgrade_selected(upgrade: AbilityUpgrade) -> void:
	upgrade_selected.emit(upgrade)
	get_tree().paused = false
	queue_free()
