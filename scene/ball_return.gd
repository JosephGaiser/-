extends Node2D

@export var ball_scene: PackedScene
@export var inventory: int = 100
@export var base_spawn_delay: float = .2

var spawn_delay_timer: Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_delay_timer = Timer.new()
	spawn_delay_timer.wait_time = base_spawn_delay
	spawn_delay_timer.autostart = true
	add_child(spawn_delay_timer)
	spawn_delay_timer.connect("timeout", _on_spawn_delay_timeout)


func _on_spawn_delay_timeout():
	if inventory > 0:
		spawn_ball()


func spawn_ball():
	if inventory > 0:
		var ball = ball_scene.instantiate()
		ball.position = self.position
		add_child(ball)
		inventory -= 1


func quick_spawn(count: int):
	inventory += count
	for i in range(count):
		await get_tree().create_timer(.1).timeout
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
