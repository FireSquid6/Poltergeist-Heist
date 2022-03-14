extends Node2D


var total_gates = 0
var gates_completed = 0

onready var gates = get_node("Gates")

func _ready():
	total_gates = gates.get_child_count()


func _process(_delta):
	# move to next level
	if gates_completed == total_gates:
		pass
	
	# restart current level
	if Input.is_action_just_pressed("restart_level"):
		restart_level()


func restart_level():
	get_tree().reload_current_scene()


func change_levels(next_level):
	get_tree().change_scene(next_level)
