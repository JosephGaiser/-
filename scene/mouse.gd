class_name Mouse
extends Node2D

@onready var area_2d: Area2D = %Area2D


func _process(delta):
	position = get_viewport().get_mouse_position()


func get_overlapping_bodies() -> Array[Node2D]:
	return area_2d.get_overlapping_bodies()
