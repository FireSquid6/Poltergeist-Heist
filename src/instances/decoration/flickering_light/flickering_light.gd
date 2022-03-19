extends Light2D

var initial_scale
export var variation_min = 0
export var variation_max = 0.2


func _init():
	initial_scale = scale


func grow():
	scale = initial_scale
	scale *= (1 + rand_range(variation_max, variation_min))


func shrink():
	scale = initial_scale
	scale *= (1 - rand_range(variation_max, variation_min))


func frame_changed():
	if scale.x < 1:
		grow()
	else:
		shrink()
