extends RigidBody2D
class_name Ball

@onready var captured_effect: GPUParticles2D = %captured_effect
@onready var collision: AudioStreamPlayer2D = %Collision

static var concurrent_sfx_playing: int = 0
static var max_concurrent_sfx: int     = 15


func captured():
    var effect_instance: GPUParticles2D = captured_effect.duplicate()
    effect_instance.global_position = self.global_position
    effect_instance.emitting = true
    get_parent().add_child(effect_instance)
    queue_free() # Free the ball instance
    await effect_instance.finished


func _on_body_entered(body):
    if concurrent_sfx_playing <= max_concurrent_sfx:
        concurrent_sfx_playing +=1
        collision.play(0)
        await collision.finished
        concurrent_sfx_playing -= 1
