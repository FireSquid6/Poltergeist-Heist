extends Toggleable


func turn_on():
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite.frame = 1

func turn_off():
	$CollisionShape2D.set_deferred("disabled", false)
	$AnimatedSprite.frame = 0
