extends Control

@onready var inventory: Label = %Inventory
@onready var ball_return = %BallReturn

func _ready():
	inventory.text = "%04d" % ball_return.inventory

func _process(delta):
	inventory.text = "%04d" % ball_return.inventory
