extends Node2D

@export var base_speed: float = 1.0
@export var counter_clockwise: bool = true

@onready var area_2d: Area2D = %Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D

var direction: int
var speed: float    = 0
var activated: bool = false


func _ready():
    if counter_clockwise:
        direction = -1
    else:
        direction = 1


func _process(_delta):
    if activated:
        sprite_2d.rotate((speed * direction) / 10)
        if area_2d.has_overlapping_bodies():
            for body in area_2d.get_overlapping_bodies():
                hit_body(body)


func hit_body(body):
    if body.is_in_group("balls"):
        body = body as RigidBody2D
        var force: Vector2 = Vector2(0, -3000 * speed)
        body.apply_central_impulse(force)


func _on_speed_slider_value_changed(value):
    if value <= 0:
        activated = false
    else:
        activated = true
    speed = base_speed * value

