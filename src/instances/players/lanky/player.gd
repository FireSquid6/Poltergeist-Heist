extends KinematicBody2D

enum STATES {
	CONTROLLED,
	IDLE,
	COMBINED
}

var state = STATES.IDLE setget state_set

onready var velocity = Vector2(0,0)
onready var on_floor = false
export var accspd = 100
export var deaccspd = 100
export var maxspd = 300

onready var can_jump = false
onready var jumping = false
export var jump_time = 0.2
export var jump_spd = 400
const GRV = 30


func _physics_process(delta):
	on_floor = $FloorDetector.is_colliding() or $FloorDetector2.is_colliding()
	
	match state:
		STATES.CONTROLLED:
			# get input
			var move = int(Input.is_action_pressed("plr_right")) - int(Input.is_action_pressed("plr_left"))
			var jump = Input.is_action_pressed("plr_jump")
			
			# move
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
			velocity = move_and_slide(velocity)
			
			# change color and text 
			$CollisionShape2D/Polygon2D.color = Color(1, 0, 0, 1)
			
		STATES.IDLE:
			# move vertically
			if !on_floor:
				velocity.y += GRV
			
			# decelerate
			# check if velocity needs to snap to 0
			if abs(velocity.x) <= deaccspd:
				velocity.x = 0
			#otherwise just subtract deacceleration speed
			else:
				velocity.x -= deaccspd * sign(velocity.x)
			
			# move
			velocity = move_and_slide(velocity)
			
			# change color
			$CollisionShape2D/Polygon2D.color = Color(1, 1, 1, 1)
	
	$Label.text = str(velocity)

var text = str(velocity)

func push(vel):
	velocity = move_and_slide(vel)

# called whenever the player jumps
func on_jump():
	velocity.y -= jump_spd
	
	jumping = true
	can_jump = false
	
	$Timers/JumpTime.wait_time = jump_time
	$Timers/JumpTime.start()


func _on_JumpTime_timeout():
	jumping = false


func state_set(new_state):
	state = new_state
	
	match state:
		STATES.IDLE:
			visible = true
		STATES.CONTROLLED:
			visible = true
		STATES.COMBINED:
			visible = false
