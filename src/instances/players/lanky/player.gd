extends Movable
class_name Player

enum STATES {
	CONTROLLED,
	IDLE,
	COMBINED
}

var state = STATES.IDLE setget state_set

export var accspd = 100
export var deaccspd = 100
export var maxspd = 300

onready var can_jump = false
export var jump_time = 0.2
export var jump_spd = 400


func _init():
	pushable = true


func _physics_process(delta):
	heavy = Global.players_combined
	
	match state:
		STATES.CONTROLLED:
			# get input
			var move = int(Input.is_action_pressed("plr_right")) - int(Input.is_action_pressed("plr_left"))
			var jump = Input.is_action_pressed("plr_jump")
			
			# play walking sound
			if move != 0 and on_floor:
				if !$Audio/Walk.playing:
					$Audio/Walk.play()
			else:
				$Audio/Walk.stop()
			
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
			if on_floor:
				velocity.y = 0
				if jump:
					on_jump()
			# if already jumping
			elif !do_gravity:
				if !jump:
					do_gravity = true
			
		STATES.IDLE:
			# decelerate
			# check if velocity needs to snap to 0
			if abs(velocity.x) <= deaccspd:
				velocity.x = 0
			#otherwise just subtract deacceleration speed
			else:
				velocity.x -= deaccspd * sign(velocity.x)
			
		
	process_movement()
	$Label.text = str(velocity) + " " + str(position) + "\n" + str(on_floor)


# called whenever the player jumps
func on_jump():
	velocity.y -= jump_spd
	
	$Audio/Jump.play()
	
	can_jump = false
	do_gravity = false
	
	$Timers/JumpTime.wait_time = jump_time
	$Timers/JumpTime.start()


func _on_JumpTime_timeout():
	do_gravity = true


func state_set(new_state):
	$Audio/Walk.stop()
	state = new_state
	
	if state == STATES.COMBINED:
		visible = false
		$CollisionShape2D.disabled = true
	else:
		visible = true
		$CollisionShape2D.disabled = false
	
	match state:
		STATES.IDLE:
			pushable = true
			visible = true
		STATES.CONTROLLED:
			pushable = false
			visible = true
		STATES.COMBINED:
			visible = false
