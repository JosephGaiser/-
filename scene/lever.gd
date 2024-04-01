extends Node2D

@export var base_speed: float = 0.2
@export var counter_clockwise: bool = true

@onready var sprite_2d: Sprite2D = $Sprite2D

var direction: int
var speed: float         = 0
var activated: bool      = false
var balls_in_area: Array = []  # Array to keep track of balls in the area


func _ready():
	if counter_clockwise:
		direction = -1
	else:
		direction = 1


func _process(_delta):
	if activated:
		sprite_2d.rotate(speed * direction)


func _physics_process(delta):
	for ball in balls_in_area:
		var force: Vector2 = Vector2(0, -5000 * speed)
		ball.apply_impulse(force)


func _on_speed_slider_value_changed(value):
	if value <= 0:
		activated = false
	else:
		activated = true
	speed = base_speed * value


func _on_area_2d_body_entered(body):
	if body.is_in_group("balls"):
		body = body as RigidBody2D
		balls_in_area.append(body)


func _on_area_2d_body_exited(body):
	if body.is_in_group("balls"):
		balls_in_area.erase(body)

