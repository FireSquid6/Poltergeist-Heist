extends Toggleable

export var start_open = false

func _ready():
	if start_open:
		turn_on()

func turn_on():
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite.frame = 1

func turn_off():
	$CollisionShape2D.set_deferred("disabled", false)
	$AnimatedSprite.frame = 0
