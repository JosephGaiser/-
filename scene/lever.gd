extends Node2D

@export var base_speed: float = 1.0
@export var counter_clockwise: bool = true
@export var min_angle: float = -90.0  # Minimum angle in degrees
@export var max_angle: float = 90.0   # Maximum angle in degrees
@export var line_length: float = 100.0  # Length of the line representing the angle

@onready var area_2d: Area2D = %Area2D
@onready var spinner_sprite: Sprite2D = %"Spinner Sprite"
@onready var angle_sprite: Sprite2D = %"Angle Sprite"

var direction: int
var speed: float    = 0
var angle: float    = 0
var activated: bool = false


func _ready():
	if counter_clockwise:
		direction = -1
	else:
		direction = 1


func _process(_delta):
	if activated:
		spinner_sprite.rotate((speed * direction) / 10)
		if area_2d.has_overlapping_bodies():
			for body in area_2d.get_overlapping_bodies():
				hit_body(body)


func hit_body(body):
	if body.is_in_group("balls"):
		body = body as RigidBody2D
		var force_direction: Vector2 = Vector2(cos(angle), sin(angle))  # Calculate force direction from angle
		var force: Vector2           = force_direction * -3000 * speed
		print("Force: ", force)
		print("Angle: ", angle)
		print("force_direction: ", force_direction)
		print("speed: ", speed)
		body.apply_central_impulse(force)


func _on_speed_slider_value_changed(value):
	if value <= 0:
		activated = false
	else:
		activated = true
	speed = base_speed * value


func _on_angle_slider_value_changed(value):
	# Clamp the angle value between the min and max angle
	angle = clamp(value, min_angle, max_angle)
	angle_sprite.rotation = angle
