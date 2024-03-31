extends Node2D
class_name main

@export var ball_scene: PackedScene


func _input(event):
	if event.is_action_pressed("spawn_ball"):
		var ball = ball_scene.instantiate()
		ball.position = event.position
		add_child(ball)
