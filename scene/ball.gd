class_name Ball
extends RigidBody2D

@export var collision_threshold: float = 600

@onready var captured_effect: GPUParticles2D = %captured_effect
@onready var lost_effect: GPUParticles2D = %lost_effect
@onready var collision: AudioStreamPlayer2D = %Collision

static var concurrent_sfx_playing: int = 0
static var max_concurrent_sfx: int = 3


func captured():
	var effect_instance: GPUParticles2D = captured_effect.duplicate()
	effect_instance.global_position = self.global_position
	effect_instance.emitting = true
	get_parent().add_child(effect_instance)
	queue_free()  # Free the ball instance
	await effect_instance.finished


func lost():
	lost_effect.emitting = true


func _on_body_entered(_body) -> void:
	var impact_level: float = linear_velocity.length()
	if impact_level < collision_threshold:
		return
	if concurrent_sfx_playing <= max_concurrent_sfx:
		concurrent_sfx_playing += 1
		collision.play(0)
		await collision.finished
		concurrent_sfx_playing -= 1
