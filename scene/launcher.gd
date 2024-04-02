class_name Launcher
extends Node2D

@export var base_speed: float = 1.0
@export var counter_clockwise: bool = true
@export var min_angle: float = -90.0  # Minimum angle in degrees
@export var max_angle: float = 90.0  # Maximum angle in degrees
@export var line_length: float = 100.0  # Length of the line representing the angle
@export var strenth: float = 1000
@export var fire_rate: float = 1.0  # How many seconds between each shot

var direction: int         = 1 # Defualt Clockwise
var speed: float           = 0
var angle: float           = 0
var activated: bool        = false
var fire_rate_timer: Timer = Timer.new()

@onready var spinner_sprite: Sprite2D = %SpinnerSprite
@onready var angle_sprite: Sprite2D = %AngleSprite
@onready var speed_slider: HSlider = %SpeedSlider
@onready var launch_location = %LaunchLocation
@onready var ball_in_feed = %BallInFeed
@onready var ball_in_launcher = %BallInLauncher

func _ready():
	if counter_clockwise:
		direction = -1 # Counter-clockwise
	fire_rate_timer.wait_time = fire_rate
	fire_rate_timer.autostart = true
	add_child(fire_rate_timer)
	fire_rate_timer.connect("timeout", _on_fire_rate_timer_timeout)


func _process(_delta) -> void:
	if !activated:
		return
	spinner_sprite.rotate((speed * direction) / 10)


func launch(body: RigidBody2D, load_ball: bool) -> void:
	if load_ball:
		body.position = launch_location.global_position
		body.linear_velocity = Vector2(0, 0)
	var force_direction: Vector2 = Vector2(cos(angle), sin(angle))
	var force: Vector2           = force_direction * -strenth * speed
	print("apply_central_impulse: ", force)
	body.apply_central_impulse(force)


func _on_fire_rate_timer_timeout() -> void:
	if !activated:
		return
	if ball_in_launcher.has_overlapping_bodies():
		for obstruction in ball_in_launcher.get_overlapping_bodies():
			if obstruction.is_in_group("balls"):
				launch(obstruction as RigidBody2D, false)
				return
	if ball_in_feed.has_overlapping_bodies():
		for body in ball_in_feed.get_overlapping_bodies():
			if body.is_in_group("balls"):
				launch(body as RigidBody2D, true)
				return


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
