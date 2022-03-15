extends Node2D


onready var gates = get_node("Gates")

func _ready():
	pass


func _process(_delta):
	# restart current level
	if Input.is_action_just_pressed("restart_level"):
		restart_level()


func restart_level():
	get_tree().reload_current_scene()


func change_level(next_level):
	get_tree().change_scene(next_level)
