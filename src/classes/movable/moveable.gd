extends KinematicBody2D
class_name Movable


var velocity = Vector2(0, 0)
var on_floor = 0
var do_gravity = true
var pushable = false

const GRV = 30

onready var manager = get_node("MoveableManager")
onready var floor_detector = get_node("MoveableManage/FloorDetector")


func process_movement():
	# fall
	if !on_floor and do_gravity:
		velocity.y += GRV
	
	#


func push(vel):
	move_and_slide(vel)


func on_floor():
	
