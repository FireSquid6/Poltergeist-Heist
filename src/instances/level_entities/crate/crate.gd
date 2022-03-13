extends KinematicBody2D
class_name Crate

export var heavy = false
onready var pushable = true

func push(velocity: Vector2) -> void:
	move_and_slide(velocity, Vector2())


func _process(_delta):
	if heavy:
		pushable = Global.players_combined
