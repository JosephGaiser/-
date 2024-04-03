extends Control

signal jackpot_hit
@export var spin_duration: float = 2.0

# Increase the frequency of "1" to increase its chance of being selected
var wheel_1_values: Array[Variant] = ["1", "1", "1", "2", "3", "4", "5"]
var wheel_2_values: Array[Variant] = ["1", "1", "1", "2", "3", "4", "5"]
var wheel_3_values: Array[Variant] = ["1", "1", "1", "2", "3", "4", "5"]
var wheel_1_spinning: bool = false
var wheel_2_spinning: bool = false
var wheel_3_spinning: bool = false
var spin_timer: Timer = Timer.new()

@onready var wheel_1: Label = $Label1
@onready var wheel_2: Label = $Label2
@onready var wheel_3: Label = $Label3


func _ready():
	add_child(spin_timer)
	spin_timer.connect("timeout", _on_spin_timer_timeout)
	spin_timer.set_wait_time(0.01)
	spin_timer.set_one_shot(false)


func _on_spin_timer_timeout():
	if wheel_1_spinning:
		wheel_1.text = wheel_1_values[randi() % wheel_1_values.size()]
	if wheel_2_spinning:
		wheel_2.text = wheel_2_values[randi() % wheel_2_values.size()]
	if wheel_3_spinning:
		wheel_3.text = wheel_3_values[randi() % wheel_3_values.size()]


func start_spin():
	spin_timer.start()
	wheel_1_spinning = true
	wheel_2_spinning = true
	wheel_3_spinning = true

	# Stop wheel 1
	await get_tree().create_timer(spin_duration / 3).timeout
	wheel_1_spinning = false

	# Stop wheel 2
	await get_tree().create_timer(spin_duration / 2).timeout
	wheel_2_spinning = false

	# Stop wheel 3
	await get_tree().create_timer(spin_duration).timeout
	wheel_3_spinning = false

	stop_spin()
	check_jackpot()


func stop_spin():
	spin_timer.stop()


func _on_crit_crit_captured():
	start_spin()


func check_jackpot():
	if wheel_1.text == wheel_2.text && wheel_2.text == wheel_3.text:
		print("JACKPOT!")
		jackpot_hit.emit()
