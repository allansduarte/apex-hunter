extends Node
class_name CharacterBase

# Base attributes
var max_hp: int = 100
var current_hp: int = 100
var base_damage: int = 10
var base_defense: int = 5
var character_name: String = "Character"

func _init() -> void:
	current_hp = max_hp

func take_damage(damage: int) -> void:
	var actual_damage: int = max(1, damage - base_defense)
	current_hp -= actual_damage
	if current_hp < 0:
		current_hp = 0

func heal(amount: int) -> void:
	current_hp += amount
	if current_hp > max_hp:
		current_hp = max_hp

func is_alive() -> bool:
	return current_hp > 0

func reset_hp() -> void:
	current_hp = max_hp
