extends StaticBody2D

@export var collision_polygon_2d: CollisionPolygon2D
@export var color: Color = Color(1, 1, 1)  # White


func _draw():
	var vertices: PackedVector2Array = collision_polygon_2d.polygon
	for i in range(vertices.size()):
		var start: Vector2 = vertices[i]
		var end: Vector2 = vertices[(i + 1) % vertices.size()]
		draw_line(start, end, color)
