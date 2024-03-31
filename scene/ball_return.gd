extends Node2D

@export var ball_scene: PackedScene
@export var inventory: int = 100
@export var base_spawn_delay: float = .2

var spawn_delay_timer: Timer
var active_spawn_delay: float = base_spawn_delay
var balls_to_spawn: int       = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_delay_timer = Timer.new()
	spawn_delay_timer.wait_time = active_spawn_delay
	spawn_delay_timer.autostart = true
	add_child(spawn_delay_timer)
	spawn_delay_timer.connect("timeout", _on_spawn_delay_timeout)


func _on_spawn_delay_timeout():
	if balls_to_spawn > 0:
		balls_to_spawn -= 1
	if balls_to_spawn <= 0:
		balls_to_spawn = 0
		active_spawn_delay = base_spawn_delay  # Reset spawn delay

	spawn_delay_timer.wait_time = active_spawn_delay # Update timer delay
	if inventory > 0:
		spawn_ball()


func spawn_ball():
	var ball = ball_scene.instantiate()
	ball.position = self.position
	add_child(ball)
	inventory -= 1


func quick_spawn(count: int):
	for i in range(count):
		spawn_ball()


func capture(value: int) -> void:
	quick_spawn(value)

func _on_capture_ball_captured():
	capture(1)


func _on_crit_ball_captured():
	capture(10)


func _on_capture_2_ball_captured():
	capture(2)


func _on_display_panel_jackpot_hit():
	capture(100)
