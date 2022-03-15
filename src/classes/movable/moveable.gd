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
	set_safe_margin(0.001)
	set_collision_layer_bit(9, true)


func _ready():
	setup()


func process_movement():
	# fall
	if do_gravity:
		velocity.y += GRV
	
	# move
	var pre_velocity = velocity
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# push
	for i in get_slide_count():
		var collided = get_slide_collision(i).collider
		if (collided as Movable != null) and (floor(collided.position.y) <= floor(position.y)):
			if collided.push(Vector2(pre_velocity.x, 0), false):
				velocity = pre_velocity
				#move_and_slide(velocity)
		
	# get on floor
	on_floor = is_on_floor()


func push(vel: Vector2, force: bool) -> bool:
	if pushable and !force:
		move_and_slide(vel)
		return true
	else:
		return false
