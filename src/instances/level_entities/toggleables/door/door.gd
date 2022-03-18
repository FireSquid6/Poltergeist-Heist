extends Toggleable

export var start_open = false

func _ready():
	if start_open:
		turn_on()

func turn_on():
	$Open.play()
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite.frame = 1

func turn_off():
	$Close.play()
	$CollisionShape2D.set_deferred("disabled", false)
	$AnimatedSprite.frame = 0
