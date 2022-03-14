extends AnimatedSprite


onready var stubby = get_parent()

func _process(delta):
	if stubby.on_floor and abs(stubby.velocity.x) > 0:
		playing = true
		animation = "walking"
		scale.x = sign(stubby.velocity.x) * -1
	else:
		animation = "idle"
