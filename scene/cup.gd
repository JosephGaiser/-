class_name Cup
extends StaticBody2D

signal ball_captured
signal crit_captured
@export var capture: AudioStreamPlayer2D
@export var is_crit: bool = false
@export var damage: int = 10

@onready var walls: CollisionPolygon2D = %Walls
@onready var interior: Area2D = %Interior


func _ready():
	interior.monitoring = true


func _draw():
	var vertices: PackedVector2Array = walls.polygon
	for i in range(vertices.size()):
		var start: Vector2 = vertices[i]
		var end: Vector2 = vertices[(i + 1) % vertices.size()]
		draw_line(start, end, Color(1, 1, 1))  # white line


func _on_interior_body_entered(body):
	if body.is_in_group("balls"):
		if body.has_method("captured"):
			capture.play(1.0)
			body.captured()
			if is_crit:
				crit_captured.emit()
			ball_captured.emit()
		else:
			body.queue_free()
