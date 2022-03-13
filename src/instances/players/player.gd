extends KinematicBody2D

enum STATES {
	MOVING,
	JUMPING,
	FALLING,
	DASHING
}

const GRV = 30
onready var in_control = true

onready var velocity = Vector2(0,0)
onready var accspd = 100
onready var deaccspd = 100 
onready var maxspd = 350
onready var myspd = 0

onready var can_jump = false
onready var jumping = false
onready var jump_time = 0.2
onready var jump_spd = 400


func _physics_process(delta):
	# HORIZONTAL MOVEMENT
	# get the horizontal input
	var move = 0
	var jump = false
	if in_control:
		move = int(Input.is_action_pressed("plr_right")) - int(Input.is_action_pressed("plr_left"))
		jump = Input.is_action_pressed("plr_jump")
	
	# if moving, accelerate
	if move != 0:
		velocity.x += accspd * move
		
		# decelerate to max spd
		if abs(velocity.x) > maxspd:
			velocity.x -= deaccspd * sign(velocity.x)
		
	# decelerate if not moving
	else:
		# check if velocity needs to snap to 0
		if abs(velocity.x) <= deaccspd:
			velocity.x = 0
		#otherwise just subtract deacceleration speed
		else:
			velocity.x -= deaccspd * sign(velocity.x)
	
	
	# VERTICAL MOVEMENT
	# check if on floor
	var on_floor = $FloorDetector.is_colliding()
	
	
	# start jump if on floor and pressed
	if on_floor and jump:
		on_jump()
	# if already jumping
	elif jumping:
		if !jump:
			jumping = false
	# if not on the floor, just fall
	elif !on_floor:
		velocity.y += GRV
	
	# move and get new velocity
	var string = str(velocity)
	velocity = move_and_slide(velocity, Vector2.UP)
	string += "\n" + str(velocity)
	$Label.text = string


# called whenever the player jumps
func on_jump():
	velocity.y -= jump_spd
	
	jumping = true
	can_jump = false
	
	$Timers/JumpTime.wait_time = jump_time
	$Timers/JumpTime.start()


func _on_JumpTime_timeout():
	jumping = false
