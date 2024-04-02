class_name Pachinko
extends Node2D

@export var ball_scene: PackedScene

@onready var mouse: Mouse = %Mouse


func _input(event):
	# FOR DEBUG
	if event.is_action_pressed("spawn_ball"):
		var ball = ball_scene.instantiate()
		ball.position = event.position
		add_child(ball)
	if event.is_action_pressed("remove_ball"):
		for body in mouse.get_overlapping_bodies():
			if body.is_in_group("balls"):
				body.queue_free()
