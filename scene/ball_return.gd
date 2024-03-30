extends Node2D

@export var starting_inventory: int = 100
@export var ball_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	#    add 100 balls to the inventory for now
	for i in range(100):
		var ball = ball_scene.instantiate()
		ball.position = self.position
		print("ball position: ", ball.position)
		print("self position: ", self.position)
		add_child(ball)


