extends KinematicBody2D
class_name Crate

export var heavy = false
export var GRV = 30
onready var pushable = true
onready var velocity = Vector2(0, 0)

func push(velocity: Vector2) -> void:
	move_and_slide(velocity, Vector2())


func _physics_process(delta):
	var on_floor = $RayCast2D.is_colliding() or $RayCast2D2.is_colliding()
	if !on_floor:
		velocity.y += GRV
	else:
		velocity.y = 0
	
	move_and_slide(velocity)
	$Label.text = str(velocity)


func _process(_delta):
	if heavy:
		pushable = Global.players_combined
