extends Node2D


onready var gates = get_node("Gates")
onready var next_level = null
const FADE_TIME = 0.5

export(String) var level_name = name


func _ready():
	$Transition.fade_in(FADE_TIME)


func _process(_delta):
	# restart current level
	if Input.is_action_just_pressed("restart_level"):
		restart_level()


func restart_level():
	get_tree().reload_current_scene()


func change_level(level):
	next_level = level
	$Transition.fade_out(FADE_TIME)


func _on_Transition_transition_finished(faded_in):
	if !faded_in:
		get_tree().change_scene(next_level)
