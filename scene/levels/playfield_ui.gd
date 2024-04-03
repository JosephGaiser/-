extends Control

@onready var inventory: Label = %Inventory
@onready var ball_return = %BallReturn
@onready var stage_health: ProgressBar = %stage_health
@onready var playfield = %Playfield


func _ready():
	stage_health.fill_mode = ProgressBar.FILL_BOTTOM_TO_TOP
	stage_health.show_percentage = false
	stage_health.max_value = playfield.health
	stage_health.min_value = 0


func _process(_delta):
	stage_health.value = playfield.health
	inventory.text = "%04d" % ball_return.inventory


func _on_slots_jackpot_hit():
	print("BIG COOL EFFECT HERE")
