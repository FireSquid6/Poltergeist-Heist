extends KinematicBody2D

enum STATES {
	CONTROLLED,
	IDLE,
	COMBINING
}

onready var state = STATES.IDLE

onready var velocity = Vector2(0,0)
onready var myspd = 0
const accspd = 100
const deaccspd = 100
const maxspd = 300

onready var can_jump = false
onready var jumping = false
const jump_time = 0.2
const jump_spd = 400
const GRV = 30


func process_movement(move, jump, delta):
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
	if jumping:
		if !jump:
			jumping = false
	# if not on the floor, just fall
	elif !on_floor:
		velocity.y += GRV
	
	# move and get new velocity
	var string = str(velocity)
	velocity = move_and_slide(velocity)
	
	string += "\n" + str(velocity)
	$Label.text = string
	
	# return the collision data

func _physics_process(delta):
	match state:
		STATES.CONTROLLED:
			var move = int(Input.is_action_pressed("plr_right")) - int(Input.is_action_pressed("plr_left"))
			var jump = Input.is_action_pressed("plr_jump")
			
			var collision = process_movement(move, jump, delta)
			
			$CollisionShape2D/Polygon2D.color = Color(1, 0, 0, 1)
			
			# handle pushing entities
			if collision != null:
				if collision.collider.get_collision_mask_bit(2): # if the collided object is a player
					collision.collider.velocity = velocity
			
		STATES.IDLE:
			$CollisionShape2D/Polygon2D.color = Color(1, 1, 1, 1)
			process_movement(0, false, delta)


# called whenever the player jumps
func on_jump():
	velocity.y -= jump_spd
	
	jumping = true
	can_jump = false
	
	$Timers/JumpTime.wait_time = jump_time
	$Timers/JumpTime.start()


func _on_JumpTime_timeout():
	jumping = false


func activate():
	state = STATES.CONTROLLED


func deactivate():
	state = STATES.IDLE
