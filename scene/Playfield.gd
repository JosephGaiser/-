extends Node2D

@onready var display_panel = %DisplayPanel
@onready var label_1 = %Label1
@onready var label_2 = %Label2
@onready var label_3 = %Label3
@onready var crit = %crit

@export var health: int = 1000
@export var crit_mod: float = 10.0


func _on_crit_crit_captured():
	print(health)
	health -= crit.damage * crit_mod
	if health < 0:
		print("GAME OVER LOL")
