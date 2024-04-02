class_name Pachinko
extends Node2D

@export var ball_scene: PackedScene


func _input(event):
	if event.is_action_pressed("spawn_ball"):
		var ball = ball_scene.instantiate()
		ball.position = event.position
		add_child(ball)
