class_name Ball
extends RigidBody2D

@export var collision_sound: AudioStream
@export var capture_sound: AudioStream
@export var crit_capture_sound: AudioStream
@export var collision_threshold: float = 600


@onready var captured_effect: GPUParticles2D = %captured_effect
@onready var lost_effect: GPUParticles2D = %lost_effect
@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D

static var concurrent_sfx_playing: int = 0
static var max_concurrent_sfx: int = 10


func captured(is_crit: bool):
	collision_shape_2d.queue_free()
	sprite_2d.queue_free()
	captured_effect.emitting = true
	if is_crit:
		SoundManager.play_sound(crit_capture_sound)
	else:
		SoundManager.play_sound(capture_sound)
	


func lost():
	lost_effect.emitting = true


func _on_body_entered(body) -> void:
	var impact_level: float = linear_velocity.length()
	if impact_level > collision_threshold && concurrent_sfx_playing < max_concurrent_sfx:
		var max_impact_level: float = 2000.0
		var min_pitch: float = 0.5
		var max_pitch: float = 2.0

		# Normalize impact_level
		var normalized_impact_level: float = (impact_level - collision_threshold) / (max_impact_level - collision_threshold)

		# Scale normalized value to pitch range
		var pitch: float = (max_pitch - min_pitch) * normalized_impact_level + min_pitch

		var sfx: AudioStreamPlayer = SoundManager.play_sound_with_pitch(collision_sound, pitch)
		concurrent_sfx_playing += 1
		await sfx.finished
		if concurrent_sfx_playing > 0:
			concurrent_sfx_playing -= 1
		
