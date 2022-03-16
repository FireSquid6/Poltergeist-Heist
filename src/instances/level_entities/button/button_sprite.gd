tool
extends AnimatedSprite


func _process(delta):
	if get_parent().heavy:
		animation = "heavy"
	else:
		animation = "light"
