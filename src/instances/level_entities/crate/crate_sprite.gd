tool
extends AnimatedSprite


func _process(delta):
	frame = int(get_parent().heavy)
