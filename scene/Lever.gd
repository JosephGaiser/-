extends Node2D

@export var base_speed: float = 0.2
@export var counter_clockwise: bool = true

@onready var body: StaticBody2D = %Body

var speed: float    = 0
var direction: int
var activated: bool = false


func _ready():
	if counter_clockwise:
		direction = -1
	else:
		direction = 1


func _process(delta):
	if activated:
		body.rotate(speed * direction)


func _on_speed_slider_value_changed(value):
	if value <= 0:
		activated = false
	else:
		activated = true
	speed = base_speed * value
