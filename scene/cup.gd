extends StaticBody2D
class_name Cup

@onready var walls: CollisionPolygon2D = %Walls
@onready var interior: Area2D = %Interior
@onready var capture: AudioStreamPlayer2D = %Capture


func _ready():
    interior.monitoring = true


func _draw():
    var vertices: PackedVector2Array = walls.polygon
    for i in range(vertices.size()):
        var start: Vector2 = vertices[i]
        var end: Vector2   = vertices[(i+1) % vertices.size()]
        draw_line(start, end, Color(1, 1, 1)) # white line


func _on_interior_body_entered(body):
    if body.is_in_group("balls"):
        if body.has_method("captured"):
            capture.play(1.0)
            body.captured()
        else:
            body.queue_free()