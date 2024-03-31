extends Node2D

@export var destory_sound: AudioStreamPlayer2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("balls"):
		print("lost ball!")
		destory_sound.play()
		body.queue_free()
