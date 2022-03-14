extends AnimatedSprite


onready var stubby = get_parent()
onready var outline_material = preload("res://resources/materials/outline_material.tres")

func _process(delta):
	# control animations
	if stubby.on_floor and abs(stubby.velocity.x) > 0:
		playing = true
		animation = "walking"
		scale.x = sign(stubby.velocity.x) * -1
	else:
		animation = "idle"
	
	# control material and visibility
	match stubby.state:
		stubby.STATES.CONTROLLED:
			material = outline_material
			visible = true
		stubby.STATES.IDLE:
			material = null
			visible = true
		stubby.STATES.COMBINED:
			material = null
			visible = false
