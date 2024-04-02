extends Node2D

@export var health: int = 1000
@export var crit_mod: float = 10.0

@onready var crit = %crit


func _on_crit_crit_captured():
	print(health)
	health -= crit.damage * crit_mod
	if health < 0:
		print("GAME OVER LOL")
