extends KinematicBody2D
class_name Movable


var velocity = Vector2(0, 0)
var on_floor = false
var do_gravity = true
var pushable = false

const GRV = 30

onready var manager = get_node("MoveableManager")
onready var floor_detector = get_node("MoveableManage/FloorDetector")


func setup():
	set_safe_margin(0.0001)


func _ready():
	setup()


func process_movement():
	# fall
	if !on_floor and do_gravity:
		velocity.y += GRV
	
	# move
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# push
	for i in get_slide_count():
		var collided = get_slide_collision(i)
		if collided as Movable:
			if collided.pushable:
				collided.push(velocity)
		
	# get on floor
	on_floor = is_on_floor()


func push(vel: Vector2, force: bool) -> bool:
	if pushable and !force:
		velocity += vel
		return true
	else:
		return false
